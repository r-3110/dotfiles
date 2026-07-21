import {
  normalizeName,
  parseCsv,
  parseMasterCsv,
  renderMasterCsv,
  validatePrice,
} from "./update_sold_out_prices.ts";

function assertEquals(actual: unknown, expected: unknown): void {
  if (JSON.stringify(actual) !== JSON.stringify(expected)) {
    throw new Error(
      `不一致: actual=${JSON.stringify(actual)} expected=${
        JSON.stringify(expected)
      }`,
    );
  }
}

function assertThrows(operation: () => unknown): void {
  try {
    operation();
  } catch {
    return;
  }
  throw new Error("例外が発生しませんでした");
}

Deno.test("商品名のUnicodeと空白を正規化する", () => {
  assertEquals(normalizeName("  蓋物  碧空\t青 "), "蓋物 碧空 青");
  assertEquals(normalizeName("カ\u3099ラス"), normalizeName("ガラス"));
});

Deno.test("引用符とカンマを含むCSVを解析できる", () => {
  assertEquals(parseCsv('a,"b,c","d""e"\n'), [["a", "b,c", 'd"e']]);
});

Deno.test("master.csvを往復して列と改行を維持する", () => {
  const source = "id,商品名,値段,カテゴリ\n1,商品A,SOLD OUT,酒器\n";
  assertEquals(renderMasterCsv(parseMasterCsv(source)), source);

  const crlfSource = source.replaceAll("\n", "\r\n");
  assertEquals(renderMasterCsv(parseMasterCsv(crlfSource), "\r\n"), crlfSource);
});

Deno.test("JPYの正の整数価格だけを受理する", () => {
  assertEquals(
    validatePrice({ name: "商品A", price: "27060", currency: "JPY" }),
    "27060",
  );
  assertThrows(() =>
    validatePrice({ name: "商品A", price: "27,060", currency: "JPY" })
  );
  assertThrows(() =>
    validatePrice({ name: "商品A", price: "27060", currency: "USD" })
  );
});
