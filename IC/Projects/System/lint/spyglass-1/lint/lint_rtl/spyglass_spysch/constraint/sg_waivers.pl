################################################################################
#This is an internally genertaed by spyglass to populate Waiver Info for Reports
#Note:Spyglass does not support any perl routine like "spyDecompileWaiverInfo"
#     The routine is purely for internal usage of spyglass
################################################################################


use SpyGlass;

spyClearWaiverHashInPerl(0);

spyComputeWaivedViolCount("totalWaivedViolationCount"=>'6',
                          "totalGeneratedCount"=>'8',
                          "totalReportCount"=>'2'
                         );

spyDecompileWaiverInfo("waive_cmd_id"=>'1',
                       "waiverCmd"=>'q%waive  -rule "STARC05-2.11.3.1" -comment "Created by ICer on 01-Oct-2026 06:15:36"%',
                       "-rule"=>'q%STARC05-2.11.3.1%',
                       "-comment"=>'"Created by ICer on 01-Oct-2026 06:15:36"',
                       "violations_waived"=>'4 5 6 7',
                       "partial_violations_waived"=>'',
                       "cmd_status"=>'1',
                       "waiverfile"=>'"./spyglass-1/lint/lint_rtl/spyglass-1_waiver_file.awl"',
                       "waiverline"=>'2'
                      );

spyDecompileWaiverInfo("waive_cmd_id"=>'2',
                       "waiverCmd"=>'q%waive  -rule "STARC05-1.4.3.4" -comment "Created by ICer on 01-Oct-2026 06:17:01"%',
                       "-rule"=>'q%STARC05-1.4.3.4%',
                       "-comment"=>'"Created by ICer on 01-Oct-2026 06:17:01"',
                       "violations_waived"=>'12 13',
                       "partial_violations_waived"=>'',
                       "cmd_status"=>'1',
                       "waiverfile"=>'"./spyglass-1/lint/lint_rtl/spyglass-1_waiver_file.awl"',
                       "waiverline"=>'3'
                      );

spyWaiversDataCount("totalWaivers"=>'3',
"totalWaiversApplied"=>'2',
"totalWaiversWithRegExp"=>'0',
"totalWaiversWithRuleSpecified"=>'3',
"totalWaiversWithIpSpecified"=>'0',
"totalWaiversWithFileLine"=>'0',
                         );

spyProhibitWaiverRules(                         );

spySetWaivedViolationNumberHash("");

1;
