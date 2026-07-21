const SHOP_URL = "https://tomokiriko.stores.jp/?all_items=true";
const EXPECTED_COLUMNS = ["id", "商品名", "値段", "カテゴリ"] as const;
const EXPECTED_ITEM_COUNT = 123;
const PAGE_COUNT = 5;

export type CsvRow = {
  id: string;
  name: string;
  price: string;
  category: string;
};

type ListItem = {
  name: string;
  url: string;
  displayPrice: string;
};

type Detail = {
  name: string | null;
  price: string | null;
  currency: string | null;
};

type AuditStatus = "updated" | "unchanged" | "held";

type AuditRow = {
  id: string;
  csvName: string;
  siteName: string;
  detailUrl: string;
  oldValue: string;
  newValue: string;
  status: AuditStatus;
  reason: string;
};

export function normalizeName(value: string): string {
  return value.normalize("NFC").trim().replace(/\s+/gu, " ");
}

export function parseCsv(text: string): string[][] {
  const rows: string[][] = [];
  let row: string[] = [];
  let field = "";
  let quoted = false;

  for (let index = 0; index < text.length; index += 1) {
    const char = text[index];
    const next = text[index + 1];

    if (quoted) {
      if (char === '"' && next === '"') {
        field += '"';
        index += 1;
      } else if (char === '"') {
        quoted = false;
      } else {
        field += char;
      }
      continue;
    }

    if (char === '"' && field.length === 0) {
      quoted = true;
    } else if (char === ",") {
      row.push(field);
      field = "";
    } else if (char === "\n") {
      row.push(field.replace(/\r$/u, ""));
      rows.push(row);
      row = [];
      field = "";
    } else {
      field += char;
    }
  }

  if (quoted) throw new Error("CSVの引用符が閉じられていません");
  if (field.length > 0 || row.length > 0) {
    row.push(field.replace(/\r$/u, ""));
    rows.push(row);
  }
  return rows;
}

function escapeCsv(value: string): string {
  return /[",\r\n]/u.test(value) ? `"${value.replaceAll('"', '""')}"` : value;
}

export function serializeCsv(
  rows: readonly (readonly string[])[],
  lineEnding = "\n",
): string {
  return `${
    rows.map((row) => row.map(escapeCsv).join(",")).join(lineEnding)
  }${lineEnding}`;
}

export function parseMasterCsv(text: string): CsvRow[] {
  const [header, ...records] = parseCsv(text);
  if (
    !header || header.length !== EXPECTED_COLUMNS.length ||
    !header.every((value, index) => value === EXPECTED_COLUMNS[index])
  ) {
    throw new Error(`CSVヘッダーが不正です: ${header?.join(",") ?? "<なし>"}`);
  }

  return records.map((record, index) => {
    if (record.length !== EXPECTED_COLUMNS.length) {
      throw new Error(`CSV ${index + 2}行目の列数が不正です: ${record.length}`);
    }
    return {
      id: record[0],
      name: record[1],
      price: record[2],
      category: record[3],
    };
  });
}

export function validatePrice(detail: Detail): string {
  if (detail.currency !== "JPY") {
    throw new Error(`通貨がJPYではありません: ${detail.currency}`);
  }
  if (!detail.price || !/^[1-9]\d*$/u.test(detail.price)) {
    throw new Error(`価格が正の整数ではありません: ${detail.price}`);
  }
  return detail.price;
}

export function renderMasterCsv(
  rows: readonly CsvRow[],
  lineEnding = "\n",
): string {
  return serializeCsv(
    [
      [...EXPECTED_COLUMNS],
      ...rows.map((row) => [row.id, row.name, row.price, row.category]),
    ],
    lineEnding,
  );
}

function renderAuditCsv(rows: readonly AuditRow[]): string {
  return serializeCsv([
    [
      "id",
      "CSV商品名",
      "サイト商品名",
      "詳細URL",
      "旧値",
      "新値",
      "結果",
      "理由",
    ],
    ...rows.map((row) => [
      row.id,
      row.csvName,
      row.siteName,
      row.detailUrl,
      row.oldValue,
      row.newValue,
      row.status,
      row.reason,
    ]),
  ]);
}

class CmuxBrowser {
  #surface: string | null = null;

  async open(): Promise<void> {
    const output = await this.#run(["browser", "open", SHOP_URL]);
    const match = output.match(/surface=(surface:\d+)/u);
    if (!match) throw new Error(`ブラウザsurfaceを取得できません: ${output}`);
    this.#surface = match[1];
    await this.waitForLoad();
  }

  async close(): Promise<void> {
    if (!this.#surface) return;
    await this.#run(["close-surface", "--surface", this.#surface]);
    this.#surface = null;
  }

  async goto(url: string): Promise<void> {
    await this.#retry(async () => {
      await this.#browser(["goto", url]);
      const parsedUrl = new URL(url);
      const page = parsedUrl.searchParams.get("page");
      const expectedUrlPart = page
        ? `page=${page}`
        : parsedUrl.pathname === "/"
        ? "all_items=true"
        : parsedUrl.pathname;
      await this.#browser([
        "wait",
        "--url-contains",
        expectedUrlPart,
      ]);
      await this.waitForLoad();
    });
  }

  async waitForLoad(): Promise<void> {
    await this.#browser([
      "wait",
      "--load-state",
      "complete",
      "--timeout-ms",
      "10000",
    ]);
  }

  async waitForDetailMetadata(): Promise<void> {
    await this.#browser([
      "wait",
      "--function",
      "document.querySelector('meta[property=\\\"og:title\\\"]') !== null && document.querySelector('meta[property=\\\"product:price:amount\\\"]') !== null && document.querySelector('meta[property=\\\"product:price:currency\\\"]') !== null",
      "--timeout-ms",
      "10000",
    ]);
  }

  async evaluate<T>(expression: string): Promise<T> {
    const output = await this.#browser(["eval", expression]);
    return JSON.parse(output.trim()) as T;
  }

  async #browser(args: string[]): Promise<string> {
    if (!this.#surface) throw new Error("ブラウザが開かれていません");
    return await this.#run(["browser", this.#surface, ...args]);
  }

  async #run(args: string[]): Promise<string> {
    const command = new Deno.Command("cmux", {
      args,
      stdout: "piped",
      stderr: "piped",
    });
    const result = await command.output();
    const stdout = new TextDecoder().decode(result.stdout);
    const stderr = new TextDecoder().decode(result.stderr);
    if (!result.success) {
      throw new Error(
        `cmux ${args.join(" ")} に失敗しました: ${stderr || stdout}`,
      );
    }
    return stdout;
  }

  async #retry(operation: () => Promise<void>): Promise<void> {
    let lastError: unknown;
    for (let attempt = 1; attempt <= 3; attempt += 1) {
      try {
        await operation();
        return;
      } catch (error) {
        lastError = error;
        if (attempt < 3) {
          await new Promise((resolve) => setTimeout(resolve, attempt * 500));
        }
      }
    }
    throw lastError;
  }
}

async function collectListItems(browser: CmuxBrowser): Promise<ListItem[]> {
  const items: ListItem[] = [];
  const expression = String
    .raw`JSON.stringify(Array.from(document.querySelectorAll('a[href*="/items/"]')).map((a) => {
    const lines = (a.innerText || a.textContent || '').trim().split(/\n+/).map((line) => line.trim()).filter(Boolean);
    return { name: lines.slice(0, -1).join(' '), displayPrice: lines.at(-1) || '', url: a.href };
  }))`;

  for (let page = 1; page <= PAGE_COUNT; page += 1) {
    const url = page === 1 ? SHOP_URL : `${SHOP_URL}&page=${page}`;
    await browser.goto(url);
    items.push(...await browser.evaluate<ListItem[]>(expression));
  }
  return items;
}

async function collectDetail(
  browser: CmuxBrowser,
  url: string,
): Promise<Detail> {
  let lastError: unknown;
  for (let attempt = 1; attempt <= 3; attempt += 1) {
    try {
      await browser.goto(url);
      await browser.waitForDetailMetadata();
      return await browser.evaluate<Detail>(String.raw`JSON.stringify({
    name: document.querySelector('meta[property="og:title"]')?.content || null,
    price: document.querySelector('meta[property="product:price:amount"]')?.content || null,
    currency: document.querySelector('meta[property="product:price:currency"]')?.content || null,
  })`);
    } catch (error) {
      lastError = error;
      if (attempt < 3) {
        await new Promise((resolve) => setTimeout(resolve, attempt * 500));
      }
    }
  }
  throw lastError;
}

function assertListContract(
  csvRows: readonly CsvRow[],
  siteItems: readonly ListItem[],
): void {
  if (csvRows.length !== EXPECTED_ITEM_COUNT) {
    throw new Error(
      `CSVの商品数が${EXPECTED_ITEM_COUNT}件ではありません: ${csvRows.length}`,
    );
  }
  if (siteItems.length !== EXPECTED_ITEM_COUNT) {
    throw new Error(
      `サイトの商品数が${EXPECTED_ITEM_COUNT}件ではありません: ${siteItems.length}`,
    );
  }
}

async function writeAtomically(path: string, content: string): Promise<void> {
  const temporaryPath = `${path}.tmp`;
  await Deno.writeTextFile(temporaryPath, content);
  await Deno.rename(temporaryPath, path);
}

async function main(): Promise<void> {
  const mode = Deno.args[0];
  if (
    !mode || !["--check", "--write"].includes(mode) || Deno.args.length !== 1
  ) {
    throw new Error(
      "使い方: deno run --allow-run=cmux --allow-read --allow-write scripts/update_sold_out_prices.ts --check|--write",
    );
  }

  const masterPath = "master.csv";
  const auditPath = "sold-out-price-audit.csv";
  const masterText = await Deno.readTextFile(masterPath);
  const masterLineEnding = masterText.includes("\r\n") ? "\r\n" : "\n";
  const csvRows = parseMasterCsv(masterText);
  const originalRows = csvRows.map((row) => ({ ...row }));
  const browser = new CmuxBrowser();
  const auditRows: AuditRow[] = [];

  try {
    await browser.open();
    const siteItems = await collectListItems(browser);
    assertListContract(csvRows, siteItems);

    for (let index = 0; index < csvRows.length; index += 1) {
      const csvRow = csvRows[index];
      const siteItem = siteItems[index];
      const base = {
        id: csvRow.id,
        csvName: csvRow.name,
        siteName: siteItem.name,
        detailUrl: siteItem.url,
        oldValue: csvRow.price,
      };

      if (csvRow.price !== "SOLD OUT") {
        auditRows.push({
          ...base,
          newValue: csvRow.price,
          status: "unchanged",
          reason: "既存価格",
        });
        continue;
      }
      if (normalizeName(csvRow.name) !== normalizeName(siteItem.name)) {
        auditRows.push({
          ...base,
          newValue: "",
          status: "held",
          reason: "一覧の商品名不一致",
        });
        continue;
      }

      try {
        const detail = await collectDetail(browser, siteItem.url);
        if (
          !detail.name ||
          normalizeName(detail.name) !== normalizeName(csvRow.name)
        ) {
          throw new Error(`詳細の商品名不一致: ${detail.name}`);
        }
        const price = validatePrice(detail);
        csvRow.price = price;
        auditRows.push({
          ...base,
          newValue: price,
          status: "updated",
          reason: "",
        });
      } catch (error) {
        auditRows.push({
          ...base,
          newValue: "",
          status: "held",
          reason: error instanceof Error ? error.message : String(error),
        });
      }
    }

    const updated = auditRows.filter((row) => row.status === "updated").length;
    const held = auditRows.filter((row) => row.status === "held").length;
    const unchanged = auditRows.filter((row) =>
      row.status === "unchanged"
    ).length;

    if (mode === "--write") {
      await writeAtomically(auditPath, renderAuditCsv(auditRows));
      await writeAtomically(
        masterPath,
        renderMasterCsv(csvRows, masterLineEnding),
      );
    }

    console.log(
      JSON.stringify(
        { mode, items: csvRows.length, updated, held, unchanged },
        null,
        2,
      ),
    );
    if (mode === "--check" && updated > 0) {
      console.log("--check のためファイルは更新していません");
    }
    if (held > 0) {
      console.log("保留行:");
      for (const row of auditRows.filter((row) => row.status === "held")) {
        console.log(`${row.id}\t${row.csvName}\t${row.reason}`);
      }
    }
  } catch (error) {
    Object.assign(csvRows, originalRows);
    throw error;
  } finally {
    await browser.close();
  }
}

if (import.meta.main) {
  main().catch((error) => {
    console.error(error instanceof Error ? error.message : error);
    Deno.exit(1);
  });
}
