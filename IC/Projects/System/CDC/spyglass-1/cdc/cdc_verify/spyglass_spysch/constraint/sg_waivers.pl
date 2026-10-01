################################################################################
#This is an internally genertaed by spyglass to populate Waiver Info for Reports
#Note:Spyglass does not support any perl routine like "spyDecompileWaiverInfo"
#     The routine is purely for internal usage of spyglass
################################################################################


use SpyGlass;

spyClearWaiverHashInPerl(0);

spyComputeWaivedViolCount("totalWaivedViolationCount"=>'4',
                          "totalGeneratedCount"=>'56',
                          "totalReportCount"=>'52'
                         );

spyDecompileWaiverInfo("waive_cmd_id"=>'1',
                       "waiverCmd"=>'q%waive  -rule "Ac_datahold01a" -comment "Created by ICer on 01-Oct-2026 07:05:20"%',
                       "-rule"=>'"Ac_datahold01a"',
                       "-comment"=>'"Created by ICer on 01-Oct-2026 07:05:20"',
                       "violations_waived"=>'151 152 153 154',
                       "partial_violations_waived"=>'',
                       "cmd_status"=>'1',
                       "waiverfile"=>'"./spyglass-1/cdc/cdc_verify/spyglass-1_waiver_file.awl"',
                       "waiverline"=>'1'
                      );

spyWaiversDataCount("totalWaivers"=>'1',
"totalWaiversApplied"=>'1',
"totalWaiversWithRegExp"=>'0',
"totalWaiversWithRuleSpecified"=>'1',
"totalWaiversWithIpSpecified"=>'0',
"totalWaiversWithFileLine"=>'0',
                         );

spyProhibitWaiverRules(                         );

spySetWaivedViolationNumberHash("");

1;
