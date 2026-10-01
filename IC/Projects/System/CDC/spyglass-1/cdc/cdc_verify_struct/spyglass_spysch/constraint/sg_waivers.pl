################################################################################
#This is an internally genertaed by spyglass to populate Waiver Info for Reports
#Note:Spyglass does not support any perl routine like "spyDecompileWaiverInfo"
#     The routine is purely for internal usage of spyglass
################################################################################


use SpyGlass;

spyClearWaiverHashInPerl(0);

spyComputeWaivedViolCount("totalWaivedViolationCount"=>'1',
                          "totalGeneratedCount"=>'0',
                          "totalReportCount"=>'0'
                         );

spyDecompileWaiverInfo("waive_cmd_id"=>'1',
                       "waiverCmd"=>'q%waive  -rule "Ac_conv02" -msg "4 synchronizers (SYSTEM_TOP.U0_ASYNC_FIFO.U3.sync_reg[1:0],SYSTEM_TOP.U0_ASYNC_FIFO.U3.sync_reg[3:2]) converge on flop \'SYSTEM_TOP.U0_ASYNC_FIFO.U0.rcounter[0]\' (same source divergence). Gray encoding check: \'DISABLED\'" -comment "Created by ICer on 01-Oct-2026 06:21:02"%',
                       "-rule"=>'"Ac_conv02"',
                       "-msg"=>'q%4 synchronizers (SYSTEM_TOP.U0_ASYNC_FIFO.U3.sync_reg[1:0],SYSTEM_TOP.U0_ASYNC_FIFO.U3.sync_reg[3:2]) converge on flop \'SYSTEM_TOP.U0_ASYNC_FIFO.U0.rcounter[0]\' (same source divergence). Gray encoding check: \'DISABLED\'%',
                       "-comment"=>'"Created by ICer on 01-Oct-2026 06:21:02"',
                       "violations_waived"=>'',
                       "partial_violations_waived"=>'',
                       "cmd_status"=>'1',
                       "waiverfile"=>'"./spyglass-1/cdc/cdc_verify_struct/spyglass-1_waiver_file.awl"',
                       "waiverline"=>'1'
                      );

spyDecompileWaiverInfo("waive_cmd_id"=>'2',
                       "waiverCmd"=>'q%waive  -rule "Ac_conv02" -msg "4 synchronizers (SYSTEM_TOP.U0_ASYNC_FIFO.U3.sync_reg[3:0]) converge on flop \'SYSTEM_TOP.U0_ASYNC_FIFO.U0.rcounter[0]\'. Gray encoding check: \'DISABLED\'" -comment "Created by ICer on 01-Oct-2026 06:50:44" --on_the_fly_compat_check %',
                       "-rule"=>'"Ac_conv02"',
                       "-msg"=>'q%4 synchronizers (SYSTEM_TOP.U0_ASYNC_FIFO.U3.sync_reg[3:0]) converge on flop \'SYSTEM_TOP.U0_ASYNC_FIFO.U0.rcounter[0]\'. Gray encoding check: \'DISABLED\'%',
                       "-comment"=>'"Created by ICer on 01-Oct-2026 06:50:44"',
                       "violations_waived"=>'92',
                       "partial_violations_waived"=>'',
                       "cmd_status"=>'1',
                       "waiverfile"=>'"./spyglass-1/cdc/cdc_verify_struct/spyglass-1_waiver_file.awl"',
                       "waiverline"=>'2'
                      );

spyWaiversDataCount("totalWaivers"=>'2',
"totalWaiversApplied"=>'2',
"totalWaiversWithRegExp"=>'0',
"totalWaiversWithRuleSpecified"=>'2',
"totalWaiversWithIpSpecified"=>'0',
"totalWaiversWithFileLine"=>'0',
                         );

spyProhibitWaiverRules(                         );

spySetWaivedViolationNumberHash("");

1;
