final: prev: {
  worktrunk = prev.worktrunk.overrideAttrs (oldAttrs: {
    checkFlags =
      (oldAttrs.checkFlags or [ ])
      ++ final.lib.optionals final.stdenv.isDarwin [
        "--skip=shell::utils::tests::test_process_name_and_ppid_self"
        "--skip=shell::utils::tests::test_probe_reports_invoked_name_for_sh"
      ];
  });
}
