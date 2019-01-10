
;;; All the macros and the scheme-object printing procedure
;;; are defined in compiler.s
%include "compiler.s"

section .bss
malloc_pointer:
    resq 1

section .data
const_tbl:
MAKE_VOID ; my address is 0
MAKE_NIL ; my address is 1
MAKE_BOOL(0) ; my address is 2
MAKE_BOOL(1) ; my address is 4
MAKE_LITERAL_INT(1) ; my address is 6
MAKE_LITERAL_INT(2) ; my address is 15
MAKE_LITERAL_INT(3) ; my address is 24
MAKE_LITERAL_INT(4) ; my address is 33
MAKE_LITERAL_INT(5) ; my address is 42
MAKE_LITERAL_INT(6) ; my address is 51
MAKE_LITERAL_INT(7) ; my address is 60
MAKE_LITERAL_INT(8) ; my address is 69
MAKE_LITERAL_INT(9) ; my address is 78
MAKE_LITERAL_INT(10) ; my address is 87
MAKE_LITERAL_INT(11) ; my address is 96
MAKE_LITERAL_INT(12) ; my address is 105
MAKE_LITERAL_INT(13) ; my address is 114
MAKE_LITERAL_INT(14) ; my address is 123
MAKE_LITERAL_INT(15) ; my address is 132
MAKE_LITERAL_INT(16) ; my address is 141
MAKE_LITERAL_INT(17) ; my address is 150
MAKE_LITERAL_INT(18) ; my address is 159
MAKE_LITERAL_INT(19) ; my address is 168
MAKE_LITERAL_INT(20) ; my address is 177
MAKE_LITERAL_INT(21) ; my address is 186
MAKE_LITERAL_INT(22) ; my address is 195
MAKE_LITERAL_INT(23) ; my address is 204
MAKE_LITERAL_INT(24) ; my address is 213
MAKE_LITERAL_INT(25) ; my address is 222
MAKE_LITERAL_INT(26) ; my address is 231
MAKE_LITERAL_INT(27) ; my address is 240
MAKE_LITERAL_INT(28) ; my address is 249
MAKE_LITERAL_INT(29) ; my address is 258
MAKE_LITERAL_INT(30) ; my address is 267
MAKE_LITERAL_INT(31) ; my address is 276
MAKE_LITERAL_INT(32) ; my address is 285
MAKE_LITERAL_INT(33) ; my address is 294
MAKE_LITERAL_INT(34) ; my address is 303
MAKE_LITERAL_INT(35) ; my address is 312
MAKE_LITERAL_INT(36) ; my address is 321
MAKE_LITERAL_INT(37) ; my address is 330
MAKE_LITERAL_INT(38) ; my address is 339
MAKE_LITERAL_INT(39) ; my address is 348
MAKE_LITERAL_INT(40) ; my address is 357
MAKE_LITERAL_INT(41) ; my address is 366
MAKE_LITERAL_INT(42) ; my address is 375
MAKE_LITERAL_INT(43) ; my address is 384
MAKE_LITERAL_INT(44) ; my address is 393
MAKE_LITERAL_INT(45) ; my address is 402
MAKE_LITERAL_INT(46) ; my address is 411
MAKE_LITERAL_INT(47) ; my address is 420
MAKE_LITERAL_INT(48) ; my address is 429
MAKE_LITERAL_INT(49) ; my address is 438
MAKE_LITERAL_INT(50) ; my address is 447
MAKE_LITERAL_INT(51) ; my address is 456
MAKE_LITERAL_INT(52) ; my address is 465
MAKE_LITERAL_INT(53) ; my address is 474
MAKE_LITERAL_INT(54) ; my address is 483
MAKE_LITERAL_INT(55) ; my address is 492
MAKE_LITERAL_INT(56) ; my address is 501
MAKE_LITERAL_INT(57) ; my address is 510
MAKE_LITERAL_INT(58) ; my address is 519
MAKE_LITERAL_INT(59) ; my address is 528
MAKE_LITERAL_INT(60) ; my address is 537
MAKE_LITERAL_INT(61) ; my address is 546
MAKE_LITERAL_INT(62) ; my address is 555
MAKE_LITERAL_INT(63) ; my address is 564
MAKE_LITERAL_INT(64) ; my address is 573
MAKE_LITERAL_INT(65) ; my address is 582
MAKE_LITERAL_INT(66) ; my address is 591
MAKE_LITERAL_INT(67) ; my address is 600
MAKE_LITERAL_INT(68) ; my address is 609
MAKE_LITERAL_INT(69) ; my address is 618
MAKE_LITERAL_INT(70) ; my address is 627
MAKE_LITERAL_INT(71) ; my address is 636
MAKE_LITERAL_INT(72) ; my address is 645
MAKE_LITERAL_INT(73) ; my address is 654
MAKE_LITERAL_INT(74) ; my address is 663
MAKE_LITERAL_INT(75) ; my address is 672
MAKE_LITERAL_INT(76) ; my address is 681
MAKE_LITERAL_INT(77) ; my address is 690
MAKE_LITERAL_INT(78) ; my address is 699
MAKE_LITERAL_INT(79) ; my address is 708
MAKE_LITERAL_INT(80) ; my address is 717
MAKE_LITERAL_INT(81) ; my address is 726
MAKE_LITERAL_INT(82) ; my address is 735
MAKE_LITERAL_INT(83) ; my address is 744
MAKE_LITERAL_INT(84) ; my address is 753
MAKE_LITERAL_INT(85) ; my address is 762
MAKE_LITERAL_INT(86) ; my address is 771
MAKE_LITERAL_INT(87) ; my address is 780
MAKE_LITERAL_INT(88) ; my address is 789
MAKE_LITERAL_INT(89) ; my address is 798
MAKE_LITERAL_INT(90) ; my address is 807
MAKE_LITERAL_INT(91) ; my address is 816
MAKE_LITERAL_INT(92) ; my address is 825
MAKE_LITERAL_INT(93) ; my address is 834
MAKE_LITERAL_INT(94) ; my address is 843
MAKE_LITERAL_INT(95) ; my address is 852
MAKE_LITERAL_INT(96) ; my address is 861
MAKE_LITERAL_INT(97) ; my address is 870
MAKE_LITERAL_INT(98) ; my address is 879
MAKE_LITERAL_INT(99) ; my address is 888
MAKE_LITERAL_INT(100) ; my address is 897
MAKE_LITERAL_INT(101) ; my address is 906
MAKE_LITERAL_INT(102) ; my address is 915
MAKE_LITERAL_INT(103) ; my address is 924
MAKE_LITERAL_INT(104) ; my address is 933
MAKE_LITERAL_INT(105) ; my address is 942
MAKE_LITERAL_INT(106) ; my address is 951
MAKE_LITERAL_INT(107) ; my address is 960
MAKE_LITERAL_INT(108) ; my address is 969
MAKE_LITERAL_INT(109) ; my address is 978
MAKE_LITERAL_INT(110) ; my address is 987
MAKE_LITERAL_INT(111) ; my address is 996
MAKE_LITERAL_INT(112) ; my address is 1005
MAKE_LITERAL_INT(113) ; my address is 1014
MAKE_LITERAL_INT(114) ; my address is 1023
MAKE_LITERAL_INT(115) ; my address is 1032
MAKE_LITERAL_INT(116) ; my address is 1041
MAKE_LITERAL_INT(117) ; my address is 1050
MAKE_LITERAL_INT(118) ; my address is 1059
MAKE_LITERAL_INT(119) ; my address is 1068
MAKE_LITERAL_INT(120) ; my address is 1077
MAKE_LITERAL_INT(121) ; my address is 1086
MAKE_LITERAL_INT(122) ; my address is 1095
MAKE_LITERAL_INT(123) ; my address is 1104
MAKE_LITERAL_INT(124) ; my address is 1113
MAKE_LITERAL_INT(125) ; my address is 1122
MAKE_LITERAL_INT(126) ; my address is 1131
MAKE_LITERAL_INT(127) ; my address is 1140
MAKE_LITERAL_INT(128) ; my address is 1149
MAKE_LITERAL_INT(129) ; my address is 1158
MAKE_LITERAL_INT(130) ; my address is 1167
MAKE_LITERAL_INT(131) ; my address is 1176
MAKE_LITERAL_INT(132) ; my address is 1185
MAKE_LITERAL_INT(133) ; my address is 1194
MAKE_LITERAL_INT(134) ; my address is 1203
MAKE_LITERAL_INT(135) ; my address is 1212
MAKE_LITERAL_INT(136) ; my address is 1221
MAKE_LITERAL_INT(137) ; my address is 1230
MAKE_LITERAL_INT(138) ; my address is 1239
MAKE_LITERAL_INT(139) ; my address is 1248
MAKE_LITERAL_INT(140) ; my address is 1257
MAKE_LITERAL_INT(141) ; my address is 1266
MAKE_LITERAL_INT(142) ; my address is 1275
MAKE_LITERAL_INT(143) ; my address is 1284
MAKE_LITERAL_INT(144) ; my address is 1293
MAKE_LITERAL_INT(145) ; my address is 1302
MAKE_LITERAL_INT(146) ; my address is 1311
MAKE_LITERAL_INT(147) ; my address is 1320
MAKE_LITERAL_INT(148) ; my address is 1329
MAKE_LITERAL_INT(149) ; my address is 1338
MAKE_LITERAL_INT(150) ; my address is 1347
MAKE_LITERAL_INT(151) ; my address is 1356
MAKE_LITERAL_INT(152) ; my address is 1365
MAKE_LITERAL_INT(153) ; my address is 1374
MAKE_LITERAL_INT(154) ; my address is 1383
MAKE_LITERAL_INT(155) ; my address is 1392
MAKE_LITERAL_INT(156) ; my address is 1401
MAKE_LITERAL_INT(157) ; my address is 1410
MAKE_LITERAL_INT(158) ; my address is 1419
MAKE_LITERAL_INT(159) ; my address is 1428
MAKE_LITERAL_INT(160) ; my address is 1437
MAKE_LITERAL_INT(161) ; my address is 1446
MAKE_LITERAL_INT(162) ; my address is 1455
MAKE_LITERAL_INT(163) ; my address is 1464
MAKE_LITERAL_INT(164) ; my address is 1473
MAKE_LITERAL_INT(165) ; my address is 1482
MAKE_LITERAL_INT(166) ; my address is 1491
MAKE_LITERAL_INT(167) ; my address is 1500
MAKE_LITERAL_INT(168) ; my address is 1509
MAKE_LITERAL_INT(169) ; my address is 1518
MAKE_LITERAL_INT(170) ; my address is 1527
MAKE_LITERAL_INT(171) ; my address is 1536
MAKE_LITERAL_INT(172) ; my address is 1545
MAKE_LITERAL_INT(173) ; my address is 1554
MAKE_LITERAL_INT(174) ; my address is 1563
MAKE_LITERAL_INT(175) ; my address is 1572
MAKE_LITERAL_INT(176) ; my address is 1581
MAKE_LITERAL_INT(177) ; my address is 1590
MAKE_LITERAL_INT(178) ; my address is 1599
MAKE_LITERAL_INT(179) ; my address is 1608
MAKE_LITERAL_INT(180) ; my address is 1617
MAKE_LITERAL_INT(181) ; my address is 1626
MAKE_LITERAL_INT(182) ; my address is 1635
MAKE_LITERAL_INT(183) ; my address is 1644
MAKE_LITERAL_INT(184) ; my address is 1653
MAKE_LITERAL_INT(185) ; my address is 1662
MAKE_LITERAL_INT(186) ; my address is 1671
MAKE_LITERAL_INT(187) ; my address is 1680
MAKE_LITERAL_INT(188) ; my address is 1689
MAKE_LITERAL_INT(189) ; my address is 1698
MAKE_LITERAL_INT(190) ; my address is 1707
MAKE_LITERAL_INT(191) ; my address is 1716
MAKE_LITERAL_INT(192) ; my address is 1725
MAKE_LITERAL_INT(193) ; my address is 1734
MAKE_LITERAL_INT(194) ; my address is 1743
MAKE_LITERAL_INT(195) ; my address is 1752
MAKE_LITERAL_INT(196) ; my address is 1761
MAKE_LITERAL_INT(197) ; my address is 1770
MAKE_LITERAL_INT(198) ; my address is 1779
MAKE_LITERAL_INT(199) ; my address is 1788
MAKE_LITERAL_INT(200) ; my address is 1797
MAKE_LITERAL_INT(201) ; my address is 1806
MAKE_LITERAL_INT(202) ; my address is 1815
MAKE_LITERAL_INT(203) ; my address is 1824
MAKE_LITERAL_INT(204) ; my address is 1833
MAKE_LITERAL_INT(205) ; my address is 1842
MAKE_LITERAL_INT(206) ; my address is 1851
MAKE_LITERAL_INT(207) ; my address is 1860
MAKE_LITERAL_INT(208) ; my address is 1869
MAKE_LITERAL_INT(209) ; my address is 1878
MAKE_LITERAL_INT(210) ; my address is 1887
MAKE_LITERAL_INT(211) ; my address is 1896
MAKE_LITERAL_INT(212) ; my address is 1905
MAKE_LITERAL_INT(213) ; my address is 1914
MAKE_LITERAL_INT(214) ; my address is 1923
MAKE_LITERAL_INT(215) ; my address is 1932
MAKE_LITERAL_INT(216) ; my address is 1941
MAKE_LITERAL_INT(217) ; my address is 1950
MAKE_LITERAL_INT(218) ; my address is 1959
MAKE_LITERAL_INT(219) ; my address is 1968
MAKE_LITERAL_INT(220) ; my address is 1977
MAKE_LITERAL_INT(221) ; my address is 1986
MAKE_LITERAL_INT(222) ; my address is 1995
MAKE_LITERAL_INT(223) ; my address is 2004
MAKE_LITERAL_INT(224) ; my address is 2013
MAKE_LITERAL_INT(225) ; my address is 2022
MAKE_LITERAL_INT(226) ; my address is 2031
MAKE_LITERAL_INT(227) ; my address is 2040
MAKE_LITERAL_INT(228) ; my address is 2049
MAKE_LITERAL_INT(229) ; my address is 2058
MAKE_LITERAL_INT(230) ; my address is 2067
MAKE_LITERAL_INT(231) ; my address is 2076
MAKE_LITERAL_INT(232) ; my address is 2085
MAKE_LITERAL_INT(233) ; my address is 2094
MAKE_LITERAL_INT(234) ; my address is 2103
MAKE_LITERAL_INT(235) ; my address is 2112
MAKE_LITERAL_INT(236) ; my address is 2121
MAKE_LITERAL_INT(237) ; my address is 2130
MAKE_LITERAL_INT(238) ; my address is 2139
MAKE_LITERAL_INT(239) ; my address is 2148
MAKE_LITERAL_INT(240) ; my address is 2157
MAKE_LITERAL_INT(241) ; my address is 2166
MAKE_LITERAL_INT(242) ; my address is 2175
MAKE_LITERAL_INT(243) ; my address is 2184
MAKE_LITERAL_INT(244) ; my address is 2193
MAKE_LITERAL_INT(245) ; my address is 2202
MAKE_LITERAL_INT(246) ; my address is 2211
MAKE_LITERAL_INT(247) ; my address is 2220
MAKE_LITERAL_INT(248) ; my address is 2229
MAKE_LITERAL_INT(249) ; my address is 2238
MAKE_LITERAL_INT(250) ; my address is 2247
MAKE_LITERAL_INT(251) ; my address is 2256
MAKE_LITERAL_INT(252) ; my address is 2265
MAKE_LITERAL_INT(253) ; my address is 2274
MAKE_LITERAL_INT(254) ; my address is 2283
MAKE_LITERAL_INT(255) ; my address is 2292
MAKE_LITERAL_INT(256) ; my address is 2301
MAKE_LITERAL_INT(257) ; my address is 2310
MAKE_LITERAL_INT(258) ; my address is 2319
MAKE_LITERAL_INT(259) ; my address is 2328
MAKE_LITERAL_INT(260) ; my address is 2337
MAKE_LITERAL_INT(261) ; my address is 2346
MAKE_LITERAL_INT(262) ; my address is 2355
MAKE_LITERAL_INT(263) ; my address is 2364
MAKE_LITERAL_INT(264) ; my address is 2373
MAKE_LITERAL_INT(265) ; my address is 2382
MAKE_LITERAL_INT(266) ; my address is 2391
MAKE_LITERAL_INT(267) ; my address is 2400
MAKE_LITERAL_INT(268) ; my address is 2409
MAKE_LITERAL_INT(269) ; my address is 2418
MAKE_LITERAL_INT(270) ; my address is 2427
MAKE_LITERAL_INT(271) ; my address is 2436
MAKE_LITERAL_INT(272) ; my address is 2445
MAKE_LITERAL_INT(273) ; my address is 2454
MAKE_LITERAL_INT(274) ; my address is 2463
MAKE_LITERAL_INT(275) ; my address is 2472
MAKE_LITERAL_INT(276) ; my address is 2481
MAKE_LITERAL_INT(277) ; my address is 2490
MAKE_LITERAL_INT(278) ; my address is 2499
MAKE_LITERAL_INT(279) ; my address is 2508
MAKE_LITERAL_INT(280) ; my address is 2517
MAKE_LITERAL_INT(281) ; my address is 2526
MAKE_LITERAL_INT(282) ; my address is 2535
MAKE_LITERAL_INT(283) ; my address is 2544
MAKE_LITERAL_INT(284) ; my address is 2553
MAKE_LITERAL_INT(285) ; my address is 2562
MAKE_LITERAL_INT(286) ; my address is 2571
MAKE_LITERAL_INT(287) ; my address is 2580
MAKE_LITERAL_INT(288) ; my address is 2589
MAKE_LITERAL_INT(289) ; my address is 2598
MAKE_LITERAL_INT(290) ; my address is 2607
MAKE_LITERAL_INT(291) ; my address is 2616
MAKE_LITERAL_INT(292) ; my address is 2625
MAKE_LITERAL_INT(293) ; my address is 2634
MAKE_LITERAL_INT(294) ; my address is 2643
MAKE_LITERAL_INT(295) ; my address is 2652
MAKE_LITERAL_INT(296) ; my address is 2661
MAKE_LITERAL_INT(297) ; my address is 2670
MAKE_LITERAL_INT(298) ; my address is 2679
MAKE_LITERAL_INT(299) ; my address is 2688
MAKE_LITERAL_INT(300) ; my address is 2697
MAKE_LITERAL_INT(301) ; my address is 2706
MAKE_LITERAL_INT(302) ; my address is 2715
MAKE_LITERAL_INT(303) ; my address is 2724
MAKE_LITERAL_INT(304) ; my address is 2733
MAKE_LITERAL_INT(305) ; my address is 2742
MAKE_LITERAL_INT(306) ; my address is 2751
MAKE_LITERAL_INT(307) ; my address is 2760
MAKE_LITERAL_INT(308) ; my address is 2769
MAKE_LITERAL_INT(309) ; my address is 2778
MAKE_LITERAL_INT(310) ; my address is 2787
MAKE_LITERAL_INT(311) ; my address is 2796
MAKE_LITERAL_INT(312) ; my address is 2805
MAKE_LITERAL_INT(313) ; my address is 2814
MAKE_LITERAL_INT(314) ; my address is 2823
MAKE_LITERAL_INT(315) ; my address is 2832
MAKE_LITERAL_INT(316) ; my address is 2841
MAKE_LITERAL_INT(317) ; my address is 2850
MAKE_LITERAL_INT(318) ; my address is 2859
MAKE_LITERAL_INT(319) ; my address is 2868
MAKE_LITERAL_INT(320) ; my address is 2877
MAKE_LITERAL_INT(321) ; my address is 2886
MAKE_LITERAL_INT(322) ; my address is 2895
MAKE_LITERAL_INT(323) ; my address is 2904
MAKE_LITERAL_INT(324) ; my address is 2913
MAKE_LITERAL_INT(325) ; my address is 2922
MAKE_LITERAL_INT(326) ; my address is 2931
MAKE_LITERAL_INT(327) ; my address is 2940
MAKE_LITERAL_INT(328) ; my address is 2949
MAKE_LITERAL_INT(329) ; my address is 2958
MAKE_LITERAL_INT(330) ; my address is 2967
MAKE_LITERAL_INT(331) ; my address is 2976
MAKE_LITERAL_INT(332) ; my address is 2985
MAKE_LITERAL_INT(333) ; my address is 2994
MAKE_LITERAL_INT(334) ; my address is 3003
MAKE_LITERAL_INT(335) ; my address is 3012
MAKE_LITERAL_INT(336) ; my address is 3021
MAKE_LITERAL_INT(337) ; my address is 3030
MAKE_LITERAL_INT(338) ; my address is 3039
MAKE_LITERAL_INT(339) ; my address is 3048
MAKE_LITERAL_INT(340) ; my address is 3057
MAKE_LITERAL_INT(341) ; my address is 3066
MAKE_LITERAL_INT(342) ; my address is 3075
MAKE_LITERAL_INT(343) ; my address is 3084
MAKE_LITERAL_INT(344) ; my address is 3093
MAKE_LITERAL_INT(345) ; my address is 3102
MAKE_LITERAL_INT(346) ; my address is 3111
MAKE_LITERAL_INT(347) ; my address is 3120
MAKE_LITERAL_INT(348) ; my address is 3129
MAKE_LITERAL_INT(349) ; my address is 3138
MAKE_LITERAL_INT(350) ; my address is 3147
MAKE_LITERAL_INT(351) ; my address is 3156
MAKE_LITERAL_INT(352) ; my address is 3165
MAKE_LITERAL_INT(353) ; my address is 3174
MAKE_LITERAL_INT(354) ; my address is 3183
MAKE_LITERAL_INT(355) ; my address is 3192
MAKE_LITERAL_INT(356) ; my address is 3201
MAKE_LITERAL_INT(357) ; my address is 3210
MAKE_LITERAL_INT(358) ; my address is 3219
MAKE_LITERAL_INT(359) ; my address is 3228
MAKE_LITERAL_INT(360) ; my address is 3237
MAKE_LITERAL_INT(361) ; my address is 3246
MAKE_LITERAL_INT(362) ; my address is 3255
MAKE_LITERAL_INT(363) ; my address is 3264
MAKE_LITERAL_INT(364) ; my address is 3273
MAKE_LITERAL_INT(365) ; my address is 3282
MAKE_LITERAL_INT(366) ; my address is 3291
MAKE_LITERAL_INT(367) ; my address is 3300
MAKE_LITERAL_INT(368) ; my address is 3309
MAKE_LITERAL_INT(369) ; my address is 3318
MAKE_LITERAL_INT(370) ; my address is 3327
MAKE_LITERAL_INT(371) ; my address is 3336
MAKE_LITERAL_INT(372) ; my address is 3345
MAKE_LITERAL_INT(373) ; my address is 3354
MAKE_LITERAL_INT(374) ; my address is 3363
MAKE_LITERAL_INT(375) ; my address is 3372
MAKE_LITERAL_INT(0) ; my address is 3381
MAKE_LITERAL_INT(-1) ; my address is 3390
MAKE_LITERAL_INT(-2) ; my address is 3399
MAKE_LITERAL_INT(-3) ; my address is 3408
MAKE_LITERAL_INT(-4) ; my address is 3417
MAKE_LITERAL_INT(-5) ; my address is 3426
MAKE_LITERAL_INT(-6) ; my address is 3435
MAKE_LITERAL_INT(-7) ; my address is 3444
MAKE_LITERAL_INT(-8) ; my address is 3453
MAKE_LITERAL_INT(-9) ; my address is 3462
MAKE_LITERAL_INT(-10) ; my address is 3471
MAKE_LITERAL_INT(-11) ; my address is 3480
MAKE_LITERAL_INT(-12) ; my address is 3489
MAKE_LITERAL_INT(-13) ; my address is 3498
MAKE_LITERAL_INT(-14) ; my address is 3507
MAKE_LITERAL_INT(-15) ; my address is 3516
MAKE_LITERAL_INT(-16) ; my address is 3525
MAKE_LITERAL_INT(-17) ; my address is 3534
MAKE_LITERAL_INT(-18) ; my address is 3543
MAKE_LITERAL_INT(-19) ; my address is 3552
MAKE_LITERAL_INT(-20) ; my address is 3561
MAKE_LITERAL_INT(-21) ; my address is 3570
MAKE_LITERAL_INT(-22) ; my address is 3579
MAKE_LITERAL_INT(-23) ; my address is 3588
MAKE_LITERAL_INT(-24) ; my address is 3597
MAKE_LITERAL_INT(-25) ; my address is 3606
MAKE_LITERAL_INT(-26) ; my address is 3615
MAKE_LITERAL_INT(-27) ; my address is 3624
MAKE_LITERAL_INT(-28) ; my address is 3633
MAKE_LITERAL_INT(-29) ; my address is 3642
MAKE_LITERAL_INT(-30) ; my address is 3651
MAKE_LITERAL_INT(-31) ; my address is 3660
MAKE_LITERAL_INT(-32) ; my address is 3669
MAKE_LITERAL_INT(-33) ; my address is 3678
MAKE_LITERAL_INT(-34) ; my address is 3687
MAKE_LITERAL_INT(-35) ; my address is 3696
MAKE_LITERAL_INT(-36) ; my address is 3705
MAKE_LITERAL_INT(-37) ; my address is 3714
MAKE_LITERAL_INT(-38) ; my address is 3723
MAKE_LITERAL_INT(-39) ; my address is 3732
MAKE_LITERAL_INT(-40) ; my address is 3741
MAKE_LITERAL_INT(-41) ; my address is 3750
MAKE_LITERAL_INT(-42) ; my address is 3759
MAKE_LITERAL_INT(-43) ; my address is 3768
MAKE_LITERAL_INT(-44) ; my address is 3777
MAKE_LITERAL_INT(-45) ; my address is 3786
MAKE_LITERAL_INT(-46) ; my address is 3795
MAKE_LITERAL_INT(-47) ; my address is 3804
MAKE_LITERAL_INT(-48) ; my address is 3813
MAKE_LITERAL_INT(-49) ; my address is 3822
MAKE_LITERAL_INT(-50) ; my address is 3831
MAKE_LITERAL_INT(-51) ; my address is 3840
MAKE_LITERAL_INT(-52) ; my address is 3849
MAKE_LITERAL_INT(-53) ; my address is 3858
MAKE_LITERAL_INT(-54) ; my address is 3867
MAKE_LITERAL_INT(-55) ; my address is 3876
MAKE_LITERAL_INT(-56) ; my address is 3885
MAKE_LITERAL_INT(-57) ; my address is 3894
MAKE_LITERAL_INT(-58) ; my address is 3903
MAKE_LITERAL_INT(-59) ; my address is 3912
MAKE_LITERAL_INT(-60) ; my address is 3921
MAKE_LITERAL_INT(-61) ; my address is 3930
MAKE_LITERAL_INT(-62) ; my address is 3939
MAKE_LITERAL_INT(-63) ; my address is 3948
MAKE_LITERAL_INT(-64) ; my address is 3957
MAKE_LITERAL_INT(-65) ; my address is 3966
MAKE_LITERAL_INT(-66) ; my address is 3975
MAKE_LITERAL_INT(-67) ; my address is 3984
MAKE_LITERAL_INT(-68) ; my address is 3993
MAKE_LITERAL_INT(-69) ; my address is 4002
MAKE_LITERAL_INT(-70) ; my address is 4011
MAKE_LITERAL_INT(-71) ; my address is 4020
MAKE_LITERAL_INT(-72) ; my address is 4029
MAKE_LITERAL_INT(-73) ; my address is 4038
MAKE_LITERAL_INT(-74) ; my address is 4047
MAKE_LITERAL_INT(-75) ; my address is 4056
MAKE_LITERAL_INT(-76) ; my address is 4065
MAKE_LITERAL_INT(-77) ; my address is 4074
MAKE_LITERAL_INT(-78) ; my address is 4083
MAKE_LITERAL_INT(-79) ; my address is 4092
MAKE_LITERAL_INT(-80) ; my address is 4101
MAKE_LITERAL_INT(-81) ; my address is 4110
MAKE_LITERAL_INT(-82) ; my address is 4119
MAKE_LITERAL_INT(-83) ; my address is 4128
MAKE_LITERAL_INT(-84) ; my address is 4137
MAKE_LITERAL_INT(-85) ; my address is 4146
MAKE_LITERAL_INT(-86) ; my address is 4155
MAKE_LITERAL_INT(-87) ; my address is 4164
MAKE_LITERAL_INT(-88) ; my address is 4173
MAKE_LITERAL_INT(-89) ; my address is 4182
MAKE_LITERAL_INT(-90) ; my address is 4191
MAKE_LITERAL_INT(-91) ; my address is 4200
MAKE_LITERAL_INT(-92) ; my address is 4209
MAKE_LITERAL_INT(-93) ; my address is 4218
MAKE_LITERAL_INT(-94) ; my address is 4227
MAKE_LITERAL_INT(-95) ; my address is 4236
MAKE_LITERAL_INT(-96) ; my address is 4245
MAKE_LITERAL_INT(-97) ; my address is 4254
MAKE_LITERAL_INT(-98) ; my address is 4263
MAKE_LITERAL_INT(-99) ; my address is 4272
MAKE_LITERAL_INT(-100) ; my address is 4281
MAKE_LITERAL_INT(-101) ; my address is 4290
MAKE_LITERAL_INT(-102) ; my address is 4299
MAKE_LITERAL_INT(-103) ; my address is 4308
MAKE_LITERAL_INT(-104) ; my address is 4317
MAKE_LITERAL_INT(-105) ; my address is 4326
MAKE_LITERAL_INT(-106) ; my address is 4335
MAKE_LITERAL_INT(-107) ; my address is 4344
MAKE_LITERAL_INT(-108) ; my address is 4353
MAKE_LITERAL_INT(-109) ; my address is 4362
MAKE_LITERAL_INT(-110) ; my address is 4371
MAKE_LITERAL_INT(-111) ; my address is 4380
MAKE_LITERAL_INT(-112) ; my address is 4389
MAKE_LITERAL_INT(-113) ; my address is 4398
MAKE_LITERAL_INT(-114) ; my address is 4407
MAKE_LITERAL_INT(-115) ; my address is 4416
MAKE_LITERAL_INT(-116) ; my address is 4425
MAKE_LITERAL_INT(-117) ; my address is 4434
MAKE_LITERAL_INT(-118) ; my address is 4443
MAKE_LITERAL_INT(-119) ; my address is 4452
MAKE_LITERAL_INT(-120) ; my address is 4461
MAKE_LITERAL_INT(-121) ; my address is 4470
MAKE_LITERAL_INT(-122) ; my address is 4479
MAKE_LITERAL_INT(-123) ; my address is 4488
MAKE_LITERAL_INT(-124) ; my address is 4497
MAKE_LITERAL_INT(-125) ; my address is 4506
MAKE_LITERAL_INT(-126) ; my address is 4515
MAKE_LITERAL_INT(-127) ; my address is 4524
MAKE_LITERAL_INT(-128) ; my address is 4533
MAKE_LITERAL_INT(-129) ; my address is 4542
MAKE_LITERAL_INT(-130) ; my address is 4551
MAKE_LITERAL_INT(-131) ; my address is 4560
MAKE_LITERAL_INT(-132) ; my address is 4569
MAKE_LITERAL_INT(-133) ; my address is 4578
MAKE_LITERAL_INT(-134) ; my address is 4587
MAKE_LITERAL_INT(-135) ; my address is 4596
MAKE_LITERAL_INT(-136) ; my address is 4605
MAKE_LITERAL_INT(-137) ; my address is 4614
MAKE_LITERAL_INT(-138) ; my address is 4623
MAKE_LITERAL_INT(-139) ; my address is 4632
MAKE_LITERAL_INT(-140) ; my address is 4641
MAKE_LITERAL_INT(-141) ; my address is 4650
MAKE_LITERAL_INT(-142) ; my address is 4659
MAKE_LITERAL_INT(-143) ; my address is 4668
MAKE_LITERAL_INT(-144) ; my address is 4677
MAKE_LITERAL_INT(-145) ; my address is 4686
MAKE_LITERAL_INT(-146) ; my address is 4695
MAKE_LITERAL_INT(-147) ; my address is 4704
MAKE_LITERAL_INT(-148) ; my address is 4713
MAKE_LITERAL_INT(-149) ; my address is 4722
MAKE_LITERAL_INT(-150) ; my address is 4731
MAKE_LITERAL_INT(-151) ; my address is 4740
MAKE_LITERAL_INT(-152) ; my address is 4749
MAKE_LITERAL_INT(-153) ; my address is 4758
MAKE_LITERAL_INT(-154) ; my address is 4767
MAKE_LITERAL_INT(-155) ; my address is 4776
MAKE_LITERAL_INT(-156) ; my address is 4785
MAKE_LITERAL_INT(-157) ; my address is 4794
MAKE_LITERAL_INT(-158) ; my address is 4803
MAKE_LITERAL_INT(-159) ; my address is 4812
MAKE_LITERAL_INT(-160) ; my address is 4821
MAKE_LITERAL_INT(-161) ; my address is 4830
MAKE_LITERAL_INT(-162) ; my address is 4839
MAKE_LITERAL_INT(-163) ; my address is 4848
MAKE_LITERAL_INT(-164) ; my address is 4857
MAKE_LITERAL_INT(-165) ; my address is 4866
MAKE_LITERAL_INT(-166) ; my address is 4875
MAKE_LITERAL_INT(-167) ; my address is 4884
MAKE_LITERAL_INT(-168) ; my address is 4893
MAKE_LITERAL_INT(-169) ; my address is 4902
MAKE_LITERAL_INT(-170) ; my address is 4911
MAKE_LITERAL_INT(-171) ; my address is 4920
MAKE_LITERAL_INT(-172) ; my address is 4929
MAKE_LITERAL_INT(-173) ; my address is 4938
MAKE_LITERAL_INT(-174) ; my address is 4947
MAKE_LITERAL_INT(-175) ; my address is 4956
MAKE_LITERAL_INT(-176) ; my address is 4965
MAKE_LITERAL_INT(-177) ; my address is 4974
MAKE_LITERAL_INT(-178) ; my address is 4983
MAKE_LITERAL_INT(-179) ; my address is 4992
MAKE_LITERAL_INT(-180) ; my address is 5001
MAKE_LITERAL_INT(-181) ; my address is 5010
MAKE_LITERAL_INT(-182) ; my address is 5019
MAKE_LITERAL_INT(-183) ; my address is 5028
MAKE_LITERAL_INT(-184) ; my address is 5037
MAKE_LITERAL_INT(-185) ; my address is 5046
MAKE_LITERAL_INT(-186) ; my address is 5055
MAKE_LITERAL_INT(-187) ; my address is 5064
MAKE_LITERAL_INT(-188) ; my address is 5073
MAKE_LITERAL_INT(-189) ; my address is 5082
MAKE_LITERAL_INT(-190) ; my address is 5091
MAKE_LITERAL_INT(-191) ; my address is 5100
MAKE_LITERAL_INT(-192) ; my address is 5109
MAKE_LITERAL_INT(-193) ; my address is 5118
MAKE_LITERAL_INT(-194) ; my address is 5127
MAKE_LITERAL_INT(-195) ; my address is 5136
MAKE_LITERAL_INT(-196) ; my address is 5145
MAKE_LITERAL_INT(-197) ; my address is 5154
MAKE_LITERAL_INT(-198) ; my address is 5163
MAKE_LITERAL_INT(-199) ; my address is 5172
MAKE_LITERAL_INT(-200) ; my address is 5181
MAKE_LITERAL_INT(-201) ; my address is 5190
MAKE_LITERAL_INT(-202) ; my address is 5199
MAKE_LITERAL_INT(-203) ; my address is 5208
MAKE_LITERAL_INT(-204) ; my address is 5217
MAKE_LITERAL_INT(-205) ; my address is 5226
MAKE_LITERAL_INT(-206) ; my address is 5235
MAKE_LITERAL_INT(-207) ; my address is 5244
MAKE_LITERAL_INT(-208) ; my address is 5253
MAKE_LITERAL_INT(-209) ; my address is 5262
MAKE_LITERAL_INT(-210) ; my address is 5271
MAKE_LITERAL_INT(-211) ; my address is 5280
MAKE_LITERAL_INT(-212) ; my address is 5289
MAKE_LITERAL_INT(-213) ; my address is 5298
MAKE_LITERAL_INT(-214) ; my address is 5307
MAKE_LITERAL_INT(-215) ; my address is 5316
MAKE_LITERAL_INT(-216) ; my address is 5325
MAKE_LITERAL_INT(-217) ; my address is 5334
MAKE_LITERAL_INT(-218) ; my address is 5343
MAKE_LITERAL_INT(-219) ; my address is 5352
MAKE_LITERAL_INT(-220) ; my address is 5361
MAKE_LITERAL_INT(-221) ; my address is 5370
MAKE_LITERAL_INT(-222) ; my address is 5379
MAKE_LITERAL_INT(-223) ; my address is 5388
MAKE_LITERAL_INT(-224) ; my address is 5397
MAKE_LITERAL_INT(-225) ; my address is 5406
MAKE_LITERAL_INT(-226) ; my address is 5415
MAKE_LITERAL_INT(-227) ; my address is 5424
MAKE_LITERAL_INT(-228) ; my address is 5433
MAKE_LITERAL_INT(-229) ; my address is 5442
MAKE_LITERAL_INT(-230) ; my address is 5451
MAKE_LITERAL_INT(-231) ; my address is 5460
MAKE_LITERAL_INT(-232) ; my address is 5469
MAKE_LITERAL_INT(-233) ; my address is 5478
MAKE_LITERAL_INT(-234) ; my address is 5487
MAKE_LITERAL_INT(-235) ; my address is 5496
MAKE_LITERAL_INT(-236) ; my address is 5505
MAKE_LITERAL_INT(-237) ; my address is 5514
MAKE_LITERAL_INT(-238) ; my address is 5523
MAKE_LITERAL_INT(-239) ; my address is 5532
MAKE_LITERAL_INT(-240) ; my address is 5541
MAKE_LITERAL_INT(-241) ; my address is 5550
MAKE_LITERAL_INT(-242) ; my address is 5559
MAKE_LITERAL_INT(-243) ; my address is 5568
MAKE_LITERAL_INT(-244) ; my address is 5577
MAKE_LITERAL_INT(-245) ; my address is 5586
MAKE_LITERAL_INT(-246) ; my address is 5595
MAKE_LITERAL_INT(-247) ; my address is 5604
MAKE_LITERAL_INT(-248) ; my address is 5613
MAKE_LITERAL_INT(-249) ; my address is 5622
MAKE_LITERAL_INT(-250) ; my address is 5631
MAKE_LITERAL_INT(-251) ; my address is 5640
MAKE_LITERAL_INT(-252) ; my address is 5649
MAKE_LITERAL_INT(-253) ; my address is 5658
MAKE_LITERAL_INT(-254) ; my address is 5667
MAKE_LITERAL_INT(-255) ; my address is 5676
MAKE_LITERAL_INT(-256) ; my address is 5685
MAKE_LITERAL_INT(-257) ; my address is 5694
MAKE_LITERAL_INT(-258) ; my address is 5703
MAKE_LITERAL_INT(-259) ; my address is 5712
MAKE_LITERAL_INT(-260) ; my address is 5721
MAKE_LITERAL_INT(-261) ; my address is 5730
MAKE_LITERAL_INT(-262) ; my address is 5739
MAKE_LITERAL_INT(-263) ; my address is 5748
MAKE_LITERAL_INT(-264) ; my address is 5757
MAKE_LITERAL_INT(-265) ; my address is 5766
MAKE_LITERAL_INT(-266) ; my address is 5775
MAKE_LITERAL_INT(-267) ; my address is 5784
MAKE_LITERAL_INT(-268) ; my address is 5793
MAKE_LITERAL_INT(-269) ; my address is 5802
MAKE_LITERAL_INT(-270) ; my address is 5811
MAKE_LITERAL_INT(-271) ; my address is 5820
MAKE_LITERAL_INT(-272) ; my address is 5829
MAKE_LITERAL_INT(-273) ; my address is 5838
MAKE_LITERAL_INT(-274) ; my address is 5847
MAKE_LITERAL_INT(-275) ; my address is 5856
MAKE_LITERAL_INT(-276) ; my address is 5865
MAKE_LITERAL_INT(-277) ; my address is 5874
MAKE_LITERAL_INT(-278) ; my address is 5883
MAKE_LITERAL_INT(-279) ; my address is 5892
MAKE_LITERAL_INT(-280) ; my address is 5901
MAKE_LITERAL_INT(-281) ; my address is 5910
MAKE_LITERAL_INT(-282) ; my address is 5919
MAKE_LITERAL_INT(-283) ; my address is 5928
MAKE_LITERAL_INT(-284) ; my address is 5937
MAKE_LITERAL_INT(-285) ; my address is 5946
MAKE_LITERAL_INT(-286) ; my address is 5955
MAKE_LITERAL_INT(-287) ; my address is 5964
MAKE_LITERAL_INT(-288) ; my address is 5973
MAKE_LITERAL_INT(-289) ; my address is 5982
MAKE_LITERAL_INT(-290) ; my address is 5991
MAKE_LITERAL_INT(-291) ; my address is 6000
MAKE_LITERAL_INT(-292) ; my address is 6009
MAKE_LITERAL_INT(-293) ; my address is 6018
MAKE_LITERAL_INT(-294) ; my address is 6027
MAKE_LITERAL_INT(-295) ; my address is 6036
MAKE_LITERAL_INT(-296) ; my address is 6045
MAKE_LITERAL_INT(-297) ; my address is 6054
MAKE_LITERAL_INT(-298) ; my address is 6063
MAKE_LITERAL_INT(-299) ; my address is 6072
MAKE_LITERAL_INT(-300) ; my address is 6081
MAKE_LITERAL_INT(-301) ; my address is 6090
MAKE_LITERAL_INT(-302) ; my address is 6099
MAKE_LITERAL_INT(-303) ; my address is 6108
MAKE_LITERAL_INT(-304) ; my address is 6117
MAKE_LITERAL_INT(-305) ; my address is 6126
MAKE_LITERAL_INT(-306) ; my address is 6135
MAKE_LITERAL_INT(-307) ; my address is 6144
MAKE_LITERAL_INT(-308) ; my address is 6153
MAKE_LITERAL_INT(-309) ; my address is 6162
MAKE_LITERAL_INT(-310) ; my address is 6171
MAKE_LITERAL_INT(-311) ; my address is 6180
MAKE_LITERAL_INT(-312) ; my address is 6189
MAKE_LITERAL_INT(-313) ; my address is 6198
MAKE_LITERAL_INT(-314) ; my address is 6207
MAKE_LITERAL_INT(-315) ; my address is 6216
MAKE_LITERAL_INT(-316) ; my address is 6225
MAKE_LITERAL_INT(-317) ; my address is 6234
MAKE_LITERAL_INT(-318) ; my address is 6243
MAKE_LITERAL_INT(-319) ; my address is 6252
MAKE_LITERAL_INT(-320) ; my address is 6261
MAKE_LITERAL_INT(-321) ; my address is 6270
MAKE_LITERAL_INT(-322) ; my address is 6279
MAKE_LITERAL_INT(-323) ; my address is 6288
MAKE_LITERAL_INT(-324) ; my address is 6297
MAKE_LITERAL_INT(-325) ; my address is 6306
MAKE_LITERAL_INT(-326) ; my address is 6315
MAKE_LITERAL_INT(-327) ; my address is 6324
MAKE_LITERAL_INT(-328) ; my address is 6333
MAKE_LITERAL_INT(-329) ; my address is 6342
MAKE_LITERAL_INT(-330) ; my address is 6351
MAKE_LITERAL_INT(-331) ; my address is 6360
MAKE_LITERAL_INT(-332) ; my address is 6369
MAKE_LITERAL_INT(-333) ; my address is 6378
MAKE_LITERAL_INT(-334) ; my address is 6387
MAKE_LITERAL_INT(-335) ; my address is 6396
MAKE_LITERAL_INT(-336) ; my address is 6405
MAKE_LITERAL_INT(-337) ; my address is 6414
MAKE_LITERAL_INT(-338) ; my address is 6423
MAKE_LITERAL_INT(-339) ; my address is 6432
MAKE_LITERAL_INT(-340) ; my address is 6441
MAKE_LITERAL_INT(-341) ; my address is 6450
MAKE_LITERAL_INT(-342) ; my address is 6459
MAKE_LITERAL_INT(-343) ; my address is 6468
MAKE_LITERAL_INT(-344) ; my address is 6477
MAKE_LITERAL_INT(-345) ; my address is 6486
MAKE_LITERAL_INT(-346) ; my address is 6495
MAKE_LITERAL_INT(-347) ; my address is 6504
MAKE_LITERAL_INT(-348) ; my address is 6513
MAKE_LITERAL_INT(-349) ; my address is 6522
MAKE_LITERAL_INT(-350) ; my address is 6531
MAKE_LITERAL_INT(-351) ; my address is 6540
MAKE_LITERAL_INT(-352) ; my address is 6549
MAKE_LITERAL_INT(-353) ; my address is 6558
MAKE_LITERAL_INT(-354) ; my address is 6567
MAKE_LITERAL_INT(-355) ; my address is 6576
MAKE_LITERAL_INT(-356) ; my address is 6585
MAKE_LITERAL_INT(-357) ; my address is 6594
MAKE_LITERAL_INT(-358) ; my address is 6603
MAKE_LITERAL_INT(-359) ; my address is 6612
MAKE_LITERAL_INT(-360) ; my address is 6621
MAKE_LITERAL_INT(-361) ; my address is 6630
MAKE_LITERAL_INT(-362) ; my address is 6639
MAKE_LITERAL_INT(-363) ; my address is 6648
MAKE_LITERAL_INT(-364) ; my address is 6657
MAKE_LITERAL_INT(-365) ; my address is 6666
MAKE_LITERAL_INT(-366) ; my address is 6675
MAKE_LITERAL_INT(-367) ; my address is 6684
MAKE_LITERAL_INT(-368) ; my address is 6693
MAKE_LITERAL_INT(-369) ; my address is 6702
MAKE_LITERAL_INT(-370) ; my address is 6711
MAKE_LITERAL_INT(-371) ; my address is 6720
MAKE_LITERAL_INT(-372) ; my address is 6729
MAKE_LITERAL_INT(-373) ; my address is 6738
MAKE_LITERAL_INT(-374) ; my address is 6747
MAKE_LITERAL_INT(-375) ; my address is 6756

;;; These macro definitions are required for the primitive
;;; definitions in the epilogue to work properly
%define SOB_VOID_ADDRESS const_tbl + 0
%define SOB_NIL_ADDRESS const_tbl + 1
%define SOB_FALSE_ADDRESS const_tbl + 2
%define SOB_TRUE_ADDRESS const_tbl + 4

fvar_tbl:
dq T_UNDEFINED ; i'm boolean?, my address is 0
dq T_UNDEFINED ; i'm float?, my address is 1
dq T_UNDEFINED ; i'm integer?, my address is 2
dq T_UNDEFINED ; i'm pair?, my address is 3
dq T_UNDEFINED ; i'm null?, my address is 4
dq T_UNDEFINED ; i'm char?, my address is 5
dq T_UNDEFINED ; i'm vector?, my address is 6
dq T_UNDEFINED ; i'm string?, my address is 7
dq T_UNDEFINED ; i'm procedure?, my address is 8
dq T_UNDEFINED ; i'm symbol?, my address is 9
dq T_UNDEFINED ; i'm string-length, my address is 10
dq T_UNDEFINED ; i'm string-ref, my address is 11
dq T_UNDEFINED ; i'm string-set!, my address is 12
dq T_UNDEFINED ; i'm make-string, my address is 13
dq T_UNDEFINED ; i'm vector-length, my address is 14
dq T_UNDEFINED ; i'm vector-ref, my address is 15
dq T_UNDEFINED ; i'm vector-set!, my address is 16
dq T_UNDEFINED ; i'm make-vector, my address is 17
dq T_UNDEFINED ; i'm symbol->string, my address is 18
dq T_UNDEFINED ; i'm char->integer, my address is 19
dq T_UNDEFINED ; i'm integer->char, my address is 20
dq T_UNDEFINED ; i'm eq?, my address is 21
dq T_UNDEFINED ; i'm +, my address is 22
dq T_UNDEFINED ; i'm *, my address is 23
dq T_UNDEFINED ; i'm -, my address is 24
dq T_UNDEFINED ; i'm /, my address is 25
dq T_UNDEFINED ; i'm <, my address is 26
dq T_UNDEFINED ; i'm =, my address is 27
dq T_UNDEFINED ; i'm car, my address is 28
dq T_UNDEFINED ; i'm cdr, my address is 29
dq T_UNDEFINED ; i'm set-car!, my address is 30
dq T_UNDEFINED ; i'm set-cdr!, my address is 31
dq T_UNDEFINED ; i'm cons, my address is 32
dq T_UNDEFINED ; i'm apply, my address is 33
dq T_UNDEFINED ; i'm x_375, my address is 34
dq T_UNDEFINED ; i'm x_374, my address is 35
dq T_UNDEFINED ; i'm x_373, my address is 36
dq T_UNDEFINED ; i'm x_372, my address is 37
dq T_UNDEFINED ; i'm x_371, my address is 38
dq T_UNDEFINED ; i'm x_370, my address is 39
dq T_UNDEFINED ; i'm x_369, my address is 40
dq T_UNDEFINED ; i'm x_368, my address is 41
dq T_UNDEFINED ; i'm x_367, my address is 42
dq T_UNDEFINED ; i'm x_366, my address is 43
dq T_UNDEFINED ; i'm x_365, my address is 44
dq T_UNDEFINED ; i'm x_364, my address is 45
dq T_UNDEFINED ; i'm x_363, my address is 46
dq T_UNDEFINED ; i'm x_362, my address is 47
dq T_UNDEFINED ; i'm x_361, my address is 48
dq T_UNDEFINED ; i'm x_360, my address is 49
dq T_UNDEFINED ; i'm x_359, my address is 50
dq T_UNDEFINED ; i'm x_358, my address is 51
dq T_UNDEFINED ; i'm x_357, my address is 52
dq T_UNDEFINED ; i'm x_356, my address is 53
dq T_UNDEFINED ; i'm x_355, my address is 54
dq T_UNDEFINED ; i'm x_354, my address is 55
dq T_UNDEFINED ; i'm x_353, my address is 56
dq T_UNDEFINED ; i'm x_352, my address is 57
dq T_UNDEFINED ; i'm x_351, my address is 58
dq T_UNDEFINED ; i'm x_350, my address is 59
dq T_UNDEFINED ; i'm x_349, my address is 60
dq T_UNDEFINED ; i'm x_348, my address is 61
dq T_UNDEFINED ; i'm x_347, my address is 62
dq T_UNDEFINED ; i'm x_346, my address is 63
dq T_UNDEFINED ; i'm x_345, my address is 64
dq T_UNDEFINED ; i'm x_344, my address is 65
dq T_UNDEFINED ; i'm x_343, my address is 66
dq T_UNDEFINED ; i'm x_342, my address is 67
dq T_UNDEFINED ; i'm x_341, my address is 68
dq T_UNDEFINED ; i'm x_340, my address is 69
dq T_UNDEFINED ; i'm x_339, my address is 70
dq T_UNDEFINED ; i'm x_338, my address is 71
dq T_UNDEFINED ; i'm x_337, my address is 72
dq T_UNDEFINED ; i'm x_336, my address is 73
dq T_UNDEFINED ; i'm x_335, my address is 74
dq T_UNDEFINED ; i'm x_334, my address is 75
dq T_UNDEFINED ; i'm x_333, my address is 76
dq T_UNDEFINED ; i'm x_332, my address is 77
dq T_UNDEFINED ; i'm x_331, my address is 78
dq T_UNDEFINED ; i'm x_330, my address is 79
dq T_UNDEFINED ; i'm x_329, my address is 80
dq T_UNDEFINED ; i'm x_328, my address is 81
dq T_UNDEFINED ; i'm x_327, my address is 82
dq T_UNDEFINED ; i'm x_326, my address is 83
dq T_UNDEFINED ; i'm x_325, my address is 84
dq T_UNDEFINED ; i'm x_324, my address is 85
dq T_UNDEFINED ; i'm x_323, my address is 86
dq T_UNDEFINED ; i'm x_322, my address is 87
dq T_UNDEFINED ; i'm x_321, my address is 88
dq T_UNDEFINED ; i'm x_320, my address is 89
dq T_UNDEFINED ; i'm x_319, my address is 90
dq T_UNDEFINED ; i'm x_318, my address is 91
dq T_UNDEFINED ; i'm x_317, my address is 92
dq T_UNDEFINED ; i'm x_316, my address is 93
dq T_UNDEFINED ; i'm x_315, my address is 94
dq T_UNDEFINED ; i'm x_314, my address is 95
dq T_UNDEFINED ; i'm x_313, my address is 96
dq T_UNDEFINED ; i'm x_312, my address is 97
dq T_UNDEFINED ; i'm x_311, my address is 98
dq T_UNDEFINED ; i'm x_310, my address is 99
dq T_UNDEFINED ; i'm x_309, my address is 100
dq T_UNDEFINED ; i'm x_308, my address is 101
dq T_UNDEFINED ; i'm x_307, my address is 102
dq T_UNDEFINED ; i'm x_306, my address is 103
dq T_UNDEFINED ; i'm x_305, my address is 104
dq T_UNDEFINED ; i'm x_304, my address is 105
dq T_UNDEFINED ; i'm x_303, my address is 106
dq T_UNDEFINED ; i'm x_302, my address is 107
dq T_UNDEFINED ; i'm x_301, my address is 108
dq T_UNDEFINED ; i'm x_300, my address is 109
dq T_UNDEFINED ; i'm x_299, my address is 110
dq T_UNDEFINED ; i'm x_298, my address is 111
dq T_UNDEFINED ; i'm x_297, my address is 112
dq T_UNDEFINED ; i'm x_296, my address is 113
dq T_UNDEFINED ; i'm x_295, my address is 114
dq T_UNDEFINED ; i'm x_294, my address is 115
dq T_UNDEFINED ; i'm x_293, my address is 116
dq T_UNDEFINED ; i'm x_292, my address is 117
dq T_UNDEFINED ; i'm x_291, my address is 118
dq T_UNDEFINED ; i'm x_290, my address is 119
dq T_UNDEFINED ; i'm x_289, my address is 120
dq T_UNDEFINED ; i'm x_288, my address is 121
dq T_UNDEFINED ; i'm x_287, my address is 122
dq T_UNDEFINED ; i'm x_286, my address is 123
dq T_UNDEFINED ; i'm x_285, my address is 124
dq T_UNDEFINED ; i'm x_284, my address is 125
dq T_UNDEFINED ; i'm x_283, my address is 126
dq T_UNDEFINED ; i'm x_282, my address is 127
dq T_UNDEFINED ; i'm x_281, my address is 128
dq T_UNDEFINED ; i'm x_280, my address is 129
dq T_UNDEFINED ; i'm x_279, my address is 130
dq T_UNDEFINED ; i'm x_278, my address is 131
dq T_UNDEFINED ; i'm x_277, my address is 132
dq T_UNDEFINED ; i'm x_276, my address is 133
dq T_UNDEFINED ; i'm x_275, my address is 134
dq T_UNDEFINED ; i'm x_274, my address is 135
dq T_UNDEFINED ; i'm x_273, my address is 136
dq T_UNDEFINED ; i'm x_272, my address is 137
dq T_UNDEFINED ; i'm x_271, my address is 138
dq T_UNDEFINED ; i'm x_270, my address is 139
dq T_UNDEFINED ; i'm x_269, my address is 140
dq T_UNDEFINED ; i'm x_268, my address is 141
dq T_UNDEFINED ; i'm x_267, my address is 142
dq T_UNDEFINED ; i'm x_266, my address is 143
dq T_UNDEFINED ; i'm x_265, my address is 144
dq T_UNDEFINED ; i'm x_264, my address is 145
dq T_UNDEFINED ; i'm x_263, my address is 146
dq T_UNDEFINED ; i'm x_262, my address is 147
dq T_UNDEFINED ; i'm x_261, my address is 148
dq T_UNDEFINED ; i'm x_260, my address is 149
dq T_UNDEFINED ; i'm x_259, my address is 150
dq T_UNDEFINED ; i'm x_258, my address is 151
dq T_UNDEFINED ; i'm x_257, my address is 152
dq T_UNDEFINED ; i'm x_256, my address is 153
dq T_UNDEFINED ; i'm x_255, my address is 154
dq T_UNDEFINED ; i'm x_254, my address is 155
dq T_UNDEFINED ; i'm x_253, my address is 156
dq T_UNDEFINED ; i'm x_252, my address is 157
dq T_UNDEFINED ; i'm x_251, my address is 158
dq T_UNDEFINED ; i'm x_250, my address is 159
dq T_UNDEFINED ; i'm x_249, my address is 160
dq T_UNDEFINED ; i'm x_248, my address is 161
dq T_UNDEFINED ; i'm x_247, my address is 162
dq T_UNDEFINED ; i'm x_246, my address is 163
dq T_UNDEFINED ; i'm x_245, my address is 164
dq T_UNDEFINED ; i'm x_244, my address is 165
dq T_UNDEFINED ; i'm x_243, my address is 166
dq T_UNDEFINED ; i'm x_242, my address is 167
dq T_UNDEFINED ; i'm x_241, my address is 168
dq T_UNDEFINED ; i'm x_240, my address is 169
dq T_UNDEFINED ; i'm x_239, my address is 170
dq T_UNDEFINED ; i'm x_238, my address is 171
dq T_UNDEFINED ; i'm x_237, my address is 172
dq T_UNDEFINED ; i'm x_236, my address is 173
dq T_UNDEFINED ; i'm x_235, my address is 174
dq T_UNDEFINED ; i'm x_234, my address is 175
dq T_UNDEFINED ; i'm x_233, my address is 176
dq T_UNDEFINED ; i'm x_232, my address is 177
dq T_UNDEFINED ; i'm x_231, my address is 178
dq T_UNDEFINED ; i'm x_230, my address is 179
dq T_UNDEFINED ; i'm x_229, my address is 180
dq T_UNDEFINED ; i'm x_228, my address is 181
dq T_UNDEFINED ; i'm x_227, my address is 182
dq T_UNDEFINED ; i'm x_226, my address is 183
dq T_UNDEFINED ; i'm x_225, my address is 184
dq T_UNDEFINED ; i'm x_224, my address is 185
dq T_UNDEFINED ; i'm x_223, my address is 186
dq T_UNDEFINED ; i'm x_222, my address is 187
dq T_UNDEFINED ; i'm x_221, my address is 188
dq T_UNDEFINED ; i'm x_220, my address is 189
dq T_UNDEFINED ; i'm x_219, my address is 190
dq T_UNDEFINED ; i'm x_218, my address is 191
dq T_UNDEFINED ; i'm x_217, my address is 192
dq T_UNDEFINED ; i'm x_216, my address is 193
dq T_UNDEFINED ; i'm x_215, my address is 194
dq T_UNDEFINED ; i'm x_214, my address is 195
dq T_UNDEFINED ; i'm x_213, my address is 196
dq T_UNDEFINED ; i'm x_212, my address is 197
dq T_UNDEFINED ; i'm x_211, my address is 198
dq T_UNDEFINED ; i'm x_210, my address is 199
dq T_UNDEFINED ; i'm x_209, my address is 200
dq T_UNDEFINED ; i'm x_208, my address is 201
dq T_UNDEFINED ; i'm x_207, my address is 202
dq T_UNDEFINED ; i'm x_206, my address is 203
dq T_UNDEFINED ; i'm x_205, my address is 204
dq T_UNDEFINED ; i'm x_204, my address is 205
dq T_UNDEFINED ; i'm x_203, my address is 206
dq T_UNDEFINED ; i'm x_202, my address is 207
dq T_UNDEFINED ; i'm x_201, my address is 208
dq T_UNDEFINED ; i'm x_200, my address is 209
dq T_UNDEFINED ; i'm x_199, my address is 210
dq T_UNDEFINED ; i'm x_198, my address is 211
dq T_UNDEFINED ; i'm x_197, my address is 212
dq T_UNDEFINED ; i'm x_196, my address is 213
dq T_UNDEFINED ; i'm x_195, my address is 214
dq T_UNDEFINED ; i'm x_194, my address is 215
dq T_UNDEFINED ; i'm x_193, my address is 216
dq T_UNDEFINED ; i'm x_192, my address is 217
dq T_UNDEFINED ; i'm x_191, my address is 218
dq T_UNDEFINED ; i'm x_190, my address is 219
dq T_UNDEFINED ; i'm x_189, my address is 220
dq T_UNDEFINED ; i'm x_188, my address is 221
dq T_UNDEFINED ; i'm x_187, my address is 222
dq T_UNDEFINED ; i'm x_186, my address is 223
dq T_UNDEFINED ; i'm x_185, my address is 224
dq T_UNDEFINED ; i'm x_184, my address is 225
dq T_UNDEFINED ; i'm x_183, my address is 226
dq T_UNDEFINED ; i'm x_182, my address is 227
dq T_UNDEFINED ; i'm x_181, my address is 228
dq T_UNDEFINED ; i'm x_180, my address is 229
dq T_UNDEFINED ; i'm x_179, my address is 230
dq T_UNDEFINED ; i'm x_178, my address is 231
dq T_UNDEFINED ; i'm x_177, my address is 232
dq T_UNDEFINED ; i'm x_176, my address is 233
dq T_UNDEFINED ; i'm x_175, my address is 234
dq T_UNDEFINED ; i'm x_174, my address is 235
dq T_UNDEFINED ; i'm x_173, my address is 236
dq T_UNDEFINED ; i'm x_172, my address is 237
dq T_UNDEFINED ; i'm x_171, my address is 238
dq T_UNDEFINED ; i'm x_170, my address is 239
dq T_UNDEFINED ; i'm x_169, my address is 240
dq T_UNDEFINED ; i'm x_168, my address is 241
dq T_UNDEFINED ; i'm x_167, my address is 242
dq T_UNDEFINED ; i'm x_166, my address is 243
dq T_UNDEFINED ; i'm x_165, my address is 244
dq T_UNDEFINED ; i'm x_164, my address is 245
dq T_UNDEFINED ; i'm x_163, my address is 246
dq T_UNDEFINED ; i'm x_162, my address is 247
dq T_UNDEFINED ; i'm x_161, my address is 248
dq T_UNDEFINED ; i'm x_160, my address is 249
dq T_UNDEFINED ; i'm x_159, my address is 250
dq T_UNDEFINED ; i'm x_158, my address is 251
dq T_UNDEFINED ; i'm x_157, my address is 252
dq T_UNDEFINED ; i'm x_156, my address is 253
dq T_UNDEFINED ; i'm x_155, my address is 254
dq T_UNDEFINED ; i'm x_154, my address is 255
dq T_UNDEFINED ; i'm x_153, my address is 256
dq T_UNDEFINED ; i'm x_152, my address is 257
dq T_UNDEFINED ; i'm x_151, my address is 258
dq T_UNDEFINED ; i'm x_150, my address is 259
dq T_UNDEFINED ; i'm x_149, my address is 260
dq T_UNDEFINED ; i'm x_148, my address is 261
dq T_UNDEFINED ; i'm x_147, my address is 262
dq T_UNDEFINED ; i'm x_146, my address is 263
dq T_UNDEFINED ; i'm x_145, my address is 264
dq T_UNDEFINED ; i'm x_144, my address is 265
dq T_UNDEFINED ; i'm x_143, my address is 266
dq T_UNDEFINED ; i'm x_142, my address is 267
dq T_UNDEFINED ; i'm x_141, my address is 268
dq T_UNDEFINED ; i'm x_140, my address is 269
dq T_UNDEFINED ; i'm x_139, my address is 270
dq T_UNDEFINED ; i'm x_138, my address is 271
dq T_UNDEFINED ; i'm x_137, my address is 272
dq T_UNDEFINED ; i'm x_136, my address is 273
dq T_UNDEFINED ; i'm x_135, my address is 274
dq T_UNDEFINED ; i'm x_134, my address is 275
dq T_UNDEFINED ; i'm x_133, my address is 276
dq T_UNDEFINED ; i'm x_132, my address is 277
dq T_UNDEFINED ; i'm x_131, my address is 278
dq T_UNDEFINED ; i'm x_130, my address is 279
dq T_UNDEFINED ; i'm x_129, my address is 280
dq T_UNDEFINED ; i'm x_128, my address is 281
dq T_UNDEFINED ; i'm x_127, my address is 282
dq T_UNDEFINED ; i'm x_126, my address is 283
dq T_UNDEFINED ; i'm x_125, my address is 284
dq T_UNDEFINED ; i'm x_124, my address is 285
dq T_UNDEFINED ; i'm x_123, my address is 286
dq T_UNDEFINED ; i'm x_122, my address is 287
dq T_UNDEFINED ; i'm x_121, my address is 288
dq T_UNDEFINED ; i'm x_120, my address is 289
dq T_UNDEFINED ; i'm x_119, my address is 290
dq T_UNDEFINED ; i'm x_118, my address is 291
dq T_UNDEFINED ; i'm x_117, my address is 292
dq T_UNDEFINED ; i'm x_116, my address is 293
dq T_UNDEFINED ; i'm x_115, my address is 294
dq T_UNDEFINED ; i'm x_114, my address is 295
dq T_UNDEFINED ; i'm x_113, my address is 296
dq T_UNDEFINED ; i'm x_112, my address is 297
dq T_UNDEFINED ; i'm x_111, my address is 298
dq T_UNDEFINED ; i'm x_110, my address is 299
dq T_UNDEFINED ; i'm x_109, my address is 300
dq T_UNDEFINED ; i'm x_108, my address is 301
dq T_UNDEFINED ; i'm x_107, my address is 302
dq T_UNDEFINED ; i'm x_106, my address is 303
dq T_UNDEFINED ; i'm x_105, my address is 304
dq T_UNDEFINED ; i'm x_104, my address is 305
dq T_UNDEFINED ; i'm x_103, my address is 306
dq T_UNDEFINED ; i'm x_102, my address is 307
dq T_UNDEFINED ; i'm x_101, my address is 308
dq T_UNDEFINED ; i'm x_100, my address is 309
dq T_UNDEFINED ; i'm x_99, my address is 310
dq T_UNDEFINED ; i'm x_98, my address is 311
dq T_UNDEFINED ; i'm x_97, my address is 312
dq T_UNDEFINED ; i'm x_96, my address is 313
dq T_UNDEFINED ; i'm x_95, my address is 314
dq T_UNDEFINED ; i'm x_94, my address is 315
dq T_UNDEFINED ; i'm x_93, my address is 316
dq T_UNDEFINED ; i'm x_92, my address is 317
dq T_UNDEFINED ; i'm x_91, my address is 318
dq T_UNDEFINED ; i'm x_90, my address is 319
dq T_UNDEFINED ; i'm x_89, my address is 320
dq T_UNDEFINED ; i'm x_88, my address is 321
dq T_UNDEFINED ; i'm x_87, my address is 322
dq T_UNDEFINED ; i'm x_86, my address is 323
dq T_UNDEFINED ; i'm x_85, my address is 324
dq T_UNDEFINED ; i'm x_84, my address is 325
dq T_UNDEFINED ; i'm x_83, my address is 326
dq T_UNDEFINED ; i'm x_82, my address is 327
dq T_UNDEFINED ; i'm x_81, my address is 328
dq T_UNDEFINED ; i'm x_80, my address is 329
dq T_UNDEFINED ; i'm x_79, my address is 330
dq T_UNDEFINED ; i'm x_78, my address is 331
dq T_UNDEFINED ; i'm x_77, my address is 332
dq T_UNDEFINED ; i'm x_76, my address is 333
dq T_UNDEFINED ; i'm x_75, my address is 334
dq T_UNDEFINED ; i'm x_74, my address is 335
dq T_UNDEFINED ; i'm x_73, my address is 336
dq T_UNDEFINED ; i'm x_72, my address is 337
dq T_UNDEFINED ; i'm x_71, my address is 338
dq T_UNDEFINED ; i'm x_70, my address is 339
dq T_UNDEFINED ; i'm x_69, my address is 340
dq T_UNDEFINED ; i'm x_68, my address is 341
dq T_UNDEFINED ; i'm x_67, my address is 342
dq T_UNDEFINED ; i'm x_66, my address is 343
dq T_UNDEFINED ; i'm x_65, my address is 344
dq T_UNDEFINED ; i'm x_64, my address is 345
dq T_UNDEFINED ; i'm x_63, my address is 346
dq T_UNDEFINED ; i'm x_62, my address is 347
dq T_UNDEFINED ; i'm x_61, my address is 348
dq T_UNDEFINED ; i'm x_60, my address is 349
dq T_UNDEFINED ; i'm x_59, my address is 350
dq T_UNDEFINED ; i'm x_58, my address is 351
dq T_UNDEFINED ; i'm x_57, my address is 352
dq T_UNDEFINED ; i'm x_56, my address is 353
dq T_UNDEFINED ; i'm x_55, my address is 354
dq T_UNDEFINED ; i'm x_54, my address is 355
dq T_UNDEFINED ; i'm x_53, my address is 356
dq T_UNDEFINED ; i'm x_52, my address is 357
dq T_UNDEFINED ; i'm x_51, my address is 358
dq T_UNDEFINED ; i'm x_50, my address is 359
dq T_UNDEFINED ; i'm x_49, my address is 360
dq T_UNDEFINED ; i'm x_48, my address is 361
dq T_UNDEFINED ; i'm x_47, my address is 362
dq T_UNDEFINED ; i'm x_46, my address is 363
dq T_UNDEFINED ; i'm x_45, my address is 364
dq T_UNDEFINED ; i'm x_44, my address is 365
dq T_UNDEFINED ; i'm x_43, my address is 366
dq T_UNDEFINED ; i'm x_42, my address is 367
dq T_UNDEFINED ; i'm x_41, my address is 368
dq T_UNDEFINED ; i'm x_40, my address is 369
dq T_UNDEFINED ; i'm x_39, my address is 370
dq T_UNDEFINED ; i'm x_38, my address is 371
dq T_UNDEFINED ; i'm x_37, my address is 372
dq T_UNDEFINED ; i'm x_36, my address is 373
dq T_UNDEFINED ; i'm x_35, my address is 374
dq T_UNDEFINED ; i'm x_34, my address is 375
dq T_UNDEFINED ; i'm x_33, my address is 376
dq T_UNDEFINED ; i'm x_32, my address is 377
dq T_UNDEFINED ; i'm x_31, my address is 378
dq T_UNDEFINED ; i'm x_30, my address is 379
dq T_UNDEFINED ; i'm x_29, my address is 380
dq T_UNDEFINED ; i'm x_28, my address is 381
dq T_UNDEFINED ; i'm x_27, my address is 382
dq T_UNDEFINED ; i'm x_26, my address is 383
dq T_UNDEFINED ; i'm x_25, my address is 384
dq T_UNDEFINED ; i'm x_24, my address is 385
dq T_UNDEFINED ; i'm x_23, my address is 386
dq T_UNDEFINED ; i'm x_22, my address is 387
dq T_UNDEFINED ; i'm x_21, my address is 388
dq T_UNDEFINED ; i'm x_20, my address is 389
dq T_UNDEFINED ; i'm x_19, my address is 390
dq T_UNDEFINED ; i'm x_18, my address is 391
dq T_UNDEFINED ; i'm x_17, my address is 392
dq T_UNDEFINED ; i'm x_16, my address is 393
dq T_UNDEFINED ; i'm x_15, my address is 394
dq T_UNDEFINED ; i'm x_14, my address is 395
dq T_UNDEFINED ; i'm x_13, my address is 396
dq T_UNDEFINED ; i'm x_12, my address is 397
dq T_UNDEFINED ; i'm x_11, my address is 398
dq T_UNDEFINED ; i'm x_10, my address is 399
dq T_UNDEFINED ; i'm x_9, my address is 400
dq T_UNDEFINED ; i'm x_8, my address is 401
dq T_UNDEFINED ; i'm x_7, my address is 402
dq T_UNDEFINED ; i'm x_6, my address is 403
dq T_UNDEFINED ; i'm x_5, my address is 404
dq T_UNDEFINED ; i'm x_4, my address is 405
dq T_UNDEFINED ; i'm x_3, my address is 406
dq T_UNDEFINED ; i'm x_2, my address is 407
dq T_UNDEFINED ; i'm x_1, my address is 408
dq T_UNDEFINED ; i'm x_0, my address is 409

global main
section .text
main:
    push rbp 
    mov rbp, rsp

    ;; set up the heap
    mov rdi, MB(100) ; TODO: Change Back to GB(4) Before Submit
    call malloc
    mov [malloc_pointer], rax

    ;; Set up the dummy activation frame
    ;; The dummy return address is T_UNDEFINED
    ;; (which a is a macro for 0) so that returning
    ;; from the top level (which SHOULD NOT HAPPEN
    ;; AND IS A BUG) will cause a segfault.
    push 0
    push qword SOB_NIL_ADDRESS
    push qword T_UNDEFINED
    push rsp

    jmp code_fragment

code_fragment:
    ;; Set up the primitive stdlib fvars:
    ;; Since the primtive procedures are defined in assembly,
    ;; they are not generated by scheme (define ...) expressions.
    ;; This is where we emulate the missing (define ...) expressions
    ;; for all the primitive procedures.
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_boolean)
    mov [fvar_tbl + 0 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_float)
    mov [fvar_tbl + 1 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_integer)
    mov [fvar_tbl + 2 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_pair)
    mov [fvar_tbl + 3 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_null)
    mov [fvar_tbl + 4 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_char)
    mov [fvar_tbl + 5 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_vector)
    mov [fvar_tbl + 6 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_string)
    mov [fvar_tbl + 7 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_procedure)
    mov [fvar_tbl + 8 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_symbol)
    mov [fvar_tbl + 9 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, string_length)
    mov [fvar_tbl + 10 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, string_ref)
    mov [fvar_tbl + 11 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, string_set)
    mov [fvar_tbl + 12 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, make_string)
    mov [fvar_tbl + 13 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, vector_length)
    mov [fvar_tbl + 14 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, vector_ref)
    mov [fvar_tbl + 15 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, vector_set)
    mov [fvar_tbl + 16 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, make_vector)
    mov [fvar_tbl + 17 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, symbol_to_string)
    mov [fvar_tbl + 18 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, char_to_integer)
    mov [fvar_tbl + 19 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, integer_to_char)
    mov [fvar_tbl + 20 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_eq)
    mov [fvar_tbl + 21 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_add)
    mov [fvar_tbl + 22 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_mul)
    mov [fvar_tbl + 23 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_sub)
    mov [fvar_tbl + 24 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_div)
    mov [fvar_tbl + 25 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_lt)
    mov [fvar_tbl + 26 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_equ)
    mov [fvar_tbl + 27 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, car)
    mov [fvar_tbl + 28 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, cdr)
    mov [fvar_tbl + 29 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, set_car)
    mov [fvar_tbl + 30 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, set_cdr)
    mov [fvar_tbl + 31 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, cons)
    mov [fvar_tbl + 32 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, apply)
    mov [fvar_tbl + 33 * WORD_SIZE], rax
    
user_code:
	mov rax, const_tbl+3381 ; Const 
	mov qword [fvar_tbl+409*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6 ; Const 
	mov qword [fvar_tbl+408*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+15 ; Const 
	mov qword [fvar_tbl+407*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+24 ; Const 
	mov qword [fvar_tbl+406*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+33 ; Const 
	mov qword [fvar_tbl+405*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+42 ; Const 
	mov qword [fvar_tbl+404*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+51 ; Const 
	mov qword [fvar_tbl+403*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+60 ; Const 
	mov qword [fvar_tbl+402*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+69 ; Const 
	mov qword [fvar_tbl+401*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+78 ; Const 
	mov qword [fvar_tbl+400*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+87 ; Const 
	mov qword [fvar_tbl+399*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+96 ; Const 
	mov qword [fvar_tbl+398*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+105 ; Const 
	mov qword [fvar_tbl+397*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+114 ; Const 
	mov qword [fvar_tbl+396*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+123 ; Const 
	mov qword [fvar_tbl+395*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+132 ; Const 
	mov qword [fvar_tbl+394*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+141 ; Const 
	mov qword [fvar_tbl+393*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+150 ; Const 
	mov qword [fvar_tbl+392*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+159 ; Const 
	mov qword [fvar_tbl+391*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+168 ; Const 
	mov qword [fvar_tbl+390*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+177 ; Const 
	mov qword [fvar_tbl+389*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+186 ; Const 
	mov qword [fvar_tbl+388*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+195 ; Const 
	mov qword [fvar_tbl+387*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+204 ; Const 
	mov qword [fvar_tbl+386*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+213 ; Const 
	mov qword [fvar_tbl+385*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+222 ; Const 
	mov qword [fvar_tbl+384*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+231 ; Const 
	mov qword [fvar_tbl+383*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+240 ; Const 
	mov qword [fvar_tbl+382*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+249 ; Const 
	mov qword [fvar_tbl+381*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+258 ; Const 
	mov qword [fvar_tbl+380*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+267 ; Const 
	mov qword [fvar_tbl+379*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+276 ; Const 
	mov qword [fvar_tbl+378*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+285 ; Const 
	mov qword [fvar_tbl+377*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+294 ; Const 
	mov qword [fvar_tbl+376*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+303 ; Const 
	mov qword [fvar_tbl+375*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+312 ; Const 
	mov qword [fvar_tbl+374*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+321 ; Const 
	mov qword [fvar_tbl+373*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+330 ; Const 
	mov qword [fvar_tbl+372*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+339 ; Const 
	mov qword [fvar_tbl+371*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+348 ; Const 
	mov qword [fvar_tbl+370*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+357 ; Const 
	mov qword [fvar_tbl+369*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+366 ; Const 
	mov qword [fvar_tbl+368*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+375 ; Const 
	mov qword [fvar_tbl+367*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+384 ; Const 
	mov qword [fvar_tbl+366*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+393 ; Const 
	mov qword [fvar_tbl+365*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+402 ; Const 
	mov qword [fvar_tbl+364*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+411 ; Const 
	mov qword [fvar_tbl+363*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+420 ; Const 
	mov qword [fvar_tbl+362*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+429 ; Const 
	mov qword [fvar_tbl+361*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+438 ; Const 
	mov qword [fvar_tbl+360*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+447 ; Const 
	mov qword [fvar_tbl+359*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+456 ; Const 
	mov qword [fvar_tbl+358*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+465 ; Const 
	mov qword [fvar_tbl+357*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+474 ; Const 
	mov qword [fvar_tbl+356*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+483 ; Const 
	mov qword [fvar_tbl+355*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+492 ; Const 
	mov qword [fvar_tbl+354*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+501 ; Const 
	mov qword [fvar_tbl+353*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+510 ; Const 
	mov qword [fvar_tbl+352*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+519 ; Const 
	mov qword [fvar_tbl+351*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+528 ; Const 
	mov qword [fvar_tbl+350*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+537 ; Const 
	mov qword [fvar_tbl+349*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+546 ; Const 
	mov qword [fvar_tbl+348*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+555 ; Const 
	mov qword [fvar_tbl+347*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+564 ; Const 
	mov qword [fvar_tbl+346*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+573 ; Const 
	mov qword [fvar_tbl+345*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+582 ; Const 
	mov qword [fvar_tbl+344*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+591 ; Const 
	mov qword [fvar_tbl+343*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+600 ; Const 
	mov qword [fvar_tbl+342*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+609 ; Const 
	mov qword [fvar_tbl+341*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+618 ; Const 
	mov qword [fvar_tbl+340*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+627 ; Const 
	mov qword [fvar_tbl+339*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+636 ; Const 
	mov qword [fvar_tbl+338*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+645 ; Const 
	mov qword [fvar_tbl+337*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+654 ; Const 
	mov qword [fvar_tbl+336*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+663 ; Const 
	mov qword [fvar_tbl+335*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+672 ; Const 
	mov qword [fvar_tbl+334*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+681 ; Const 
	mov qword [fvar_tbl+333*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+690 ; Const 
	mov qword [fvar_tbl+332*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+699 ; Const 
	mov qword [fvar_tbl+331*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+708 ; Const 
	mov qword [fvar_tbl+330*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+717 ; Const 
	mov qword [fvar_tbl+329*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+726 ; Const 
	mov qword [fvar_tbl+328*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+735 ; Const 
	mov qword [fvar_tbl+327*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+744 ; Const 
	mov qword [fvar_tbl+326*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+753 ; Const 
	mov qword [fvar_tbl+325*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+762 ; Const 
	mov qword [fvar_tbl+324*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+771 ; Const 
	mov qword [fvar_tbl+323*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+780 ; Const 
	mov qword [fvar_tbl+322*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+789 ; Const 
	mov qword [fvar_tbl+321*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+798 ; Const 
	mov qword [fvar_tbl+320*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+807 ; Const 
	mov qword [fvar_tbl+319*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+816 ; Const 
	mov qword [fvar_tbl+318*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+825 ; Const 
	mov qword [fvar_tbl+317*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+834 ; Const 
	mov qword [fvar_tbl+316*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+843 ; Const 
	mov qword [fvar_tbl+315*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+852 ; Const 
	mov qword [fvar_tbl+314*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+861 ; Const 
	mov qword [fvar_tbl+313*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+870 ; Const 
	mov qword [fvar_tbl+312*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+879 ; Const 
	mov qword [fvar_tbl+311*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+888 ; Const 
	mov qword [fvar_tbl+310*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+897 ; Const 
	mov qword [fvar_tbl+309*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+906 ; Const 
	mov qword [fvar_tbl+308*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+915 ; Const 
	mov qword [fvar_tbl+307*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+924 ; Const 
	mov qword [fvar_tbl+306*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+933 ; Const 
	mov qword [fvar_tbl+305*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+942 ; Const 
	mov qword [fvar_tbl+304*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+951 ; Const 
	mov qword [fvar_tbl+303*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+960 ; Const 
	mov qword [fvar_tbl+302*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+969 ; Const 
	mov qword [fvar_tbl+301*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+978 ; Const 
	mov qword [fvar_tbl+300*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+987 ; Const 
	mov qword [fvar_tbl+299*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+996 ; Const 
	mov qword [fvar_tbl+298*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1005 ; Const 
	mov qword [fvar_tbl+297*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1014 ; Const 
	mov qword [fvar_tbl+296*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1023 ; Const 
	mov qword [fvar_tbl+295*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1032 ; Const 
	mov qword [fvar_tbl+294*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1041 ; Const 
	mov qword [fvar_tbl+293*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1050 ; Const 
	mov qword [fvar_tbl+292*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1059 ; Const 
	mov qword [fvar_tbl+291*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1068 ; Const 
	mov qword [fvar_tbl+290*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1077 ; Const 
	mov qword [fvar_tbl+289*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1086 ; Const 
	mov qword [fvar_tbl+288*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1095 ; Const 
	mov qword [fvar_tbl+287*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1104 ; Const 
	mov qword [fvar_tbl+286*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1113 ; Const 
	mov qword [fvar_tbl+285*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1122 ; Const 
	mov qword [fvar_tbl+284*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1131 ; Const 
	mov qword [fvar_tbl+283*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1140 ; Const 
	mov qword [fvar_tbl+282*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1149 ; Const 
	mov qword [fvar_tbl+281*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1158 ; Const 
	mov qword [fvar_tbl+280*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1167 ; Const 
	mov qword [fvar_tbl+279*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1176 ; Const 
	mov qword [fvar_tbl+278*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1185 ; Const 
	mov qword [fvar_tbl+277*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1194 ; Const 
	mov qword [fvar_tbl+276*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1203 ; Const 
	mov qword [fvar_tbl+275*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1212 ; Const 
	mov qword [fvar_tbl+274*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1221 ; Const 
	mov qword [fvar_tbl+273*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1230 ; Const 
	mov qword [fvar_tbl+272*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1239 ; Const 
	mov qword [fvar_tbl+271*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1248 ; Const 
	mov qword [fvar_tbl+270*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1257 ; Const 
	mov qword [fvar_tbl+269*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1266 ; Const 
	mov qword [fvar_tbl+268*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1275 ; Const 
	mov qword [fvar_tbl+267*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1284 ; Const 
	mov qword [fvar_tbl+266*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1293 ; Const 
	mov qword [fvar_tbl+265*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1302 ; Const 
	mov qword [fvar_tbl+264*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1311 ; Const 
	mov qword [fvar_tbl+263*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1320 ; Const 
	mov qword [fvar_tbl+262*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1329 ; Const 
	mov qword [fvar_tbl+261*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1338 ; Const 
	mov qword [fvar_tbl+260*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1347 ; Const 
	mov qword [fvar_tbl+259*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1356 ; Const 
	mov qword [fvar_tbl+258*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1365 ; Const 
	mov qword [fvar_tbl+257*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1374 ; Const 
	mov qword [fvar_tbl+256*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1383 ; Const 
	mov qword [fvar_tbl+255*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1392 ; Const 
	mov qword [fvar_tbl+254*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1401 ; Const 
	mov qword [fvar_tbl+253*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1410 ; Const 
	mov qword [fvar_tbl+252*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1419 ; Const 
	mov qword [fvar_tbl+251*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1428 ; Const 
	mov qword [fvar_tbl+250*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1437 ; Const 
	mov qword [fvar_tbl+249*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1446 ; Const 
	mov qword [fvar_tbl+248*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1455 ; Const 
	mov qword [fvar_tbl+247*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1464 ; Const 
	mov qword [fvar_tbl+246*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1473 ; Const 
	mov qword [fvar_tbl+245*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1482 ; Const 
	mov qword [fvar_tbl+244*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1491 ; Const 
	mov qword [fvar_tbl+243*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1500 ; Const 
	mov qword [fvar_tbl+242*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1509 ; Const 
	mov qword [fvar_tbl+241*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1518 ; Const 
	mov qword [fvar_tbl+240*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1527 ; Const 
	mov qword [fvar_tbl+239*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1536 ; Const 
	mov qword [fvar_tbl+238*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1545 ; Const 
	mov qword [fvar_tbl+237*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1554 ; Const 
	mov qword [fvar_tbl+236*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1563 ; Const 
	mov qword [fvar_tbl+235*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1572 ; Const 
	mov qword [fvar_tbl+234*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1581 ; Const 
	mov qword [fvar_tbl+233*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1590 ; Const 
	mov qword [fvar_tbl+232*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1599 ; Const 
	mov qword [fvar_tbl+231*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1608 ; Const 
	mov qword [fvar_tbl+230*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1617 ; Const 
	mov qword [fvar_tbl+229*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1626 ; Const 
	mov qword [fvar_tbl+228*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1635 ; Const 
	mov qword [fvar_tbl+227*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1644 ; Const 
	mov qword [fvar_tbl+226*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1653 ; Const 
	mov qword [fvar_tbl+225*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1662 ; Const 
	mov qword [fvar_tbl+224*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1671 ; Const 
	mov qword [fvar_tbl+223*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1680 ; Const 
	mov qword [fvar_tbl+222*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1689 ; Const 
	mov qword [fvar_tbl+221*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1698 ; Const 
	mov qword [fvar_tbl+220*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1707 ; Const 
	mov qword [fvar_tbl+219*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1716 ; Const 
	mov qword [fvar_tbl+218*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1725 ; Const 
	mov qword [fvar_tbl+217*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1734 ; Const 
	mov qword [fvar_tbl+216*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1743 ; Const 
	mov qword [fvar_tbl+215*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1752 ; Const 
	mov qword [fvar_tbl+214*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1761 ; Const 
	mov qword [fvar_tbl+213*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1770 ; Const 
	mov qword [fvar_tbl+212*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1779 ; Const 
	mov qword [fvar_tbl+211*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1788 ; Const 
	mov qword [fvar_tbl+210*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1797 ; Const 
	mov qword [fvar_tbl+209*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1806 ; Const 
	mov qword [fvar_tbl+208*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1815 ; Const 
	mov qword [fvar_tbl+207*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1824 ; Const 
	mov qword [fvar_tbl+206*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1833 ; Const 
	mov qword [fvar_tbl+205*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1842 ; Const 
	mov qword [fvar_tbl+204*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1851 ; Const 
	mov qword [fvar_tbl+203*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1860 ; Const 
	mov qword [fvar_tbl+202*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1869 ; Const 
	mov qword [fvar_tbl+201*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1878 ; Const 
	mov qword [fvar_tbl+200*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1887 ; Const 
	mov qword [fvar_tbl+199*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1896 ; Const 
	mov qword [fvar_tbl+198*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1905 ; Const 
	mov qword [fvar_tbl+197*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1914 ; Const 
	mov qword [fvar_tbl+196*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1923 ; Const 
	mov qword [fvar_tbl+195*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1932 ; Const 
	mov qword [fvar_tbl+194*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1941 ; Const 
	mov qword [fvar_tbl+193*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1950 ; Const 
	mov qword [fvar_tbl+192*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1959 ; Const 
	mov qword [fvar_tbl+191*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1968 ; Const 
	mov qword [fvar_tbl+190*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1977 ; Const 
	mov qword [fvar_tbl+189*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1986 ; Const 
	mov qword [fvar_tbl+188*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+1995 ; Const 
	mov qword [fvar_tbl+187*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2004 ; Const 
	mov qword [fvar_tbl+186*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2013 ; Const 
	mov qword [fvar_tbl+185*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2022 ; Const 
	mov qword [fvar_tbl+184*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2031 ; Const 
	mov qword [fvar_tbl+183*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2040 ; Const 
	mov qword [fvar_tbl+182*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2049 ; Const 
	mov qword [fvar_tbl+181*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2058 ; Const 
	mov qword [fvar_tbl+180*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2067 ; Const 
	mov qword [fvar_tbl+179*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2076 ; Const 
	mov qword [fvar_tbl+178*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2085 ; Const 
	mov qword [fvar_tbl+177*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2094 ; Const 
	mov qword [fvar_tbl+176*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2103 ; Const 
	mov qword [fvar_tbl+175*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2112 ; Const 
	mov qword [fvar_tbl+174*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2121 ; Const 
	mov qword [fvar_tbl+173*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2130 ; Const 
	mov qword [fvar_tbl+172*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2139 ; Const 
	mov qword [fvar_tbl+171*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2148 ; Const 
	mov qword [fvar_tbl+170*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2157 ; Const 
	mov qword [fvar_tbl+169*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2166 ; Const 
	mov qword [fvar_tbl+168*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2175 ; Const 
	mov qword [fvar_tbl+167*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2184 ; Const 
	mov qword [fvar_tbl+166*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2193 ; Const 
	mov qword [fvar_tbl+165*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2202 ; Const 
	mov qword [fvar_tbl+164*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2211 ; Const 
	mov qword [fvar_tbl+163*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2220 ; Const 
	mov qword [fvar_tbl+162*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2229 ; Const 
	mov qword [fvar_tbl+161*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2238 ; Const 
	mov qword [fvar_tbl+160*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2247 ; Const 
	mov qword [fvar_tbl+159*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2256 ; Const 
	mov qword [fvar_tbl+158*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2265 ; Const 
	mov qword [fvar_tbl+157*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2274 ; Const 
	mov qword [fvar_tbl+156*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2283 ; Const 
	mov qword [fvar_tbl+155*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2292 ; Const 
	mov qword [fvar_tbl+154*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2301 ; Const 
	mov qword [fvar_tbl+153*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2310 ; Const 
	mov qword [fvar_tbl+152*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2319 ; Const 
	mov qword [fvar_tbl+151*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2328 ; Const 
	mov qword [fvar_tbl+150*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2337 ; Const 
	mov qword [fvar_tbl+149*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2346 ; Const 
	mov qword [fvar_tbl+148*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2355 ; Const 
	mov qword [fvar_tbl+147*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2364 ; Const 
	mov qword [fvar_tbl+146*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2373 ; Const 
	mov qword [fvar_tbl+145*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2382 ; Const 
	mov qword [fvar_tbl+144*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2391 ; Const 
	mov qword [fvar_tbl+143*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2400 ; Const 
	mov qword [fvar_tbl+142*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2409 ; Const 
	mov qword [fvar_tbl+141*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2418 ; Const 
	mov qword [fvar_tbl+140*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2427 ; Const 
	mov qword [fvar_tbl+139*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2436 ; Const 
	mov qword [fvar_tbl+138*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2445 ; Const 
	mov qword [fvar_tbl+137*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2454 ; Const 
	mov qword [fvar_tbl+136*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2463 ; Const 
	mov qword [fvar_tbl+135*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2472 ; Const 
	mov qword [fvar_tbl+134*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2481 ; Const 
	mov qword [fvar_tbl+133*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2490 ; Const 
	mov qword [fvar_tbl+132*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2499 ; Const 
	mov qword [fvar_tbl+131*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2508 ; Const 
	mov qword [fvar_tbl+130*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2517 ; Const 
	mov qword [fvar_tbl+129*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2526 ; Const 
	mov qword [fvar_tbl+128*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2535 ; Const 
	mov qword [fvar_tbl+127*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2544 ; Const 
	mov qword [fvar_tbl+126*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2553 ; Const 
	mov qword [fvar_tbl+125*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2562 ; Const 
	mov qword [fvar_tbl+124*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2571 ; Const 
	mov qword [fvar_tbl+123*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2580 ; Const 
	mov qword [fvar_tbl+122*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2589 ; Const 
	mov qword [fvar_tbl+121*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2598 ; Const 
	mov qword [fvar_tbl+120*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2607 ; Const 
	mov qword [fvar_tbl+119*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2616 ; Const 
	mov qword [fvar_tbl+118*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2625 ; Const 
	mov qword [fvar_tbl+117*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2634 ; Const 
	mov qword [fvar_tbl+116*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2643 ; Const 
	mov qword [fvar_tbl+115*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2652 ; Const 
	mov qword [fvar_tbl+114*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2661 ; Const 
	mov qword [fvar_tbl+113*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2670 ; Const 
	mov qword [fvar_tbl+112*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2679 ; Const 
	mov qword [fvar_tbl+111*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2688 ; Const 
	mov qword [fvar_tbl+110*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2697 ; Const 
	mov qword [fvar_tbl+109*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2706 ; Const 
	mov qword [fvar_tbl+108*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2715 ; Const 
	mov qword [fvar_tbl+107*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2724 ; Const 
	mov qword [fvar_tbl+106*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2733 ; Const 
	mov qword [fvar_tbl+105*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2742 ; Const 
	mov qword [fvar_tbl+104*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2751 ; Const 
	mov qword [fvar_tbl+103*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2760 ; Const 
	mov qword [fvar_tbl+102*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2769 ; Const 
	mov qword [fvar_tbl+101*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2778 ; Const 
	mov qword [fvar_tbl+100*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2787 ; Const 
	mov qword [fvar_tbl+99*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2796 ; Const 
	mov qword [fvar_tbl+98*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2805 ; Const 
	mov qword [fvar_tbl+97*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2814 ; Const 
	mov qword [fvar_tbl+96*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2823 ; Const 
	mov qword [fvar_tbl+95*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2832 ; Const 
	mov qword [fvar_tbl+94*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2841 ; Const 
	mov qword [fvar_tbl+93*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2850 ; Const 
	mov qword [fvar_tbl+92*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2859 ; Const 
	mov qword [fvar_tbl+91*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2868 ; Const 
	mov qword [fvar_tbl+90*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2877 ; Const 
	mov qword [fvar_tbl+89*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2886 ; Const 
	mov qword [fvar_tbl+88*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2895 ; Const 
	mov qword [fvar_tbl+87*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2904 ; Const 
	mov qword [fvar_tbl+86*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2913 ; Const 
	mov qword [fvar_tbl+85*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2922 ; Const 
	mov qword [fvar_tbl+84*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2931 ; Const 
	mov qword [fvar_tbl+83*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2940 ; Const 
	mov qword [fvar_tbl+82*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2949 ; Const 
	mov qword [fvar_tbl+81*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2958 ; Const 
	mov qword [fvar_tbl+80*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2967 ; Const 
	mov qword [fvar_tbl+79*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2976 ; Const 
	mov qword [fvar_tbl+78*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2985 ; Const 
	mov qword [fvar_tbl+77*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+2994 ; Const 
	mov qword [fvar_tbl+76*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3003 ; Const 
	mov qword [fvar_tbl+75*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3012 ; Const 
	mov qword [fvar_tbl+74*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3021 ; Const 
	mov qword [fvar_tbl+73*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3030 ; Const 
	mov qword [fvar_tbl+72*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3039 ; Const 
	mov qword [fvar_tbl+71*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3048 ; Const 
	mov qword [fvar_tbl+70*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3057 ; Const 
	mov qword [fvar_tbl+69*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3066 ; Const 
	mov qword [fvar_tbl+68*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3075 ; Const 
	mov qword [fvar_tbl+67*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3084 ; Const 
	mov qword [fvar_tbl+66*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3093 ; Const 
	mov qword [fvar_tbl+65*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3102 ; Const 
	mov qword [fvar_tbl+64*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3111 ; Const 
	mov qword [fvar_tbl+63*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3120 ; Const 
	mov qword [fvar_tbl+62*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3129 ; Const 
	mov qword [fvar_tbl+61*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3138 ; Const 
	mov qword [fvar_tbl+60*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3147 ; Const 
	mov qword [fvar_tbl+59*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3156 ; Const 
	mov qword [fvar_tbl+58*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3165 ; Const 
	mov qword [fvar_tbl+57*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3174 ; Const 
	mov qword [fvar_tbl+56*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3183 ; Const 
	mov qword [fvar_tbl+55*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3192 ; Const 
	mov qword [fvar_tbl+54*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3201 ; Const 
	mov qword [fvar_tbl+53*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3210 ; Const 
	mov qword [fvar_tbl+52*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3219 ; Const 
	mov qword [fvar_tbl+51*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3228 ; Const 
	mov qword [fvar_tbl+50*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3237 ; Const 
	mov qword [fvar_tbl+49*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3246 ; Const 
	mov qword [fvar_tbl+48*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3255 ; Const 
	mov qword [fvar_tbl+47*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3264 ; Const 
	mov qword [fvar_tbl+46*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3273 ; Const 
	mov qword [fvar_tbl+45*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3282 ; Const 
	mov qword [fvar_tbl+44*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3291 ; Const 
	mov qword [fvar_tbl+43*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3300 ; Const 
	mov qword [fvar_tbl+42*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3309 ; Const 
	mov qword [fvar_tbl+41*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3318 ; Const 
	mov qword [fvar_tbl+40*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3327 ; Const 
	mov qword [fvar_tbl+39*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3336 ; Const 
	mov qword [fvar_tbl+38*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3345 ; Const 
	mov qword [fvar_tbl+37*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3354 ; Const 
	mov qword [fvar_tbl+36*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3363 ; Const 
	mov qword [fvar_tbl+35*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3372 ; Const 
	mov qword [fvar_tbl+34*WORD_SIZE], rax ; define 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3381 ; Const 
	mov qword [fvar_tbl+409*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3390 ; Const 
	mov qword [fvar_tbl+408*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3399 ; Const 
	mov qword [fvar_tbl+407*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3408 ; Const 
	mov qword [fvar_tbl+406*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3417 ; Const 
	mov qword [fvar_tbl+405*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3426 ; Const 
	mov qword [fvar_tbl+404*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3435 ; Const 
	mov qword [fvar_tbl+403*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3444 ; Const 
	mov qword [fvar_tbl+402*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3453 ; Const 
	mov qword [fvar_tbl+401*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3462 ; Const 
	mov qword [fvar_tbl+400*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3471 ; Const 
	mov qword [fvar_tbl+399*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3480 ; Const 
	mov qword [fvar_tbl+398*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3489 ; Const 
	mov qword [fvar_tbl+397*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3498 ; Const 
	mov qword [fvar_tbl+396*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3507 ; Const 
	mov qword [fvar_tbl+395*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3516 ; Const 
	mov qword [fvar_tbl+394*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3525 ; Const 
	mov qword [fvar_tbl+393*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3534 ; Const 
	mov qword [fvar_tbl+392*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3543 ; Const 
	mov qword [fvar_tbl+391*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3552 ; Const 
	mov qword [fvar_tbl+390*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3561 ; Const 
	mov qword [fvar_tbl+389*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3570 ; Const 
	mov qword [fvar_tbl+388*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3579 ; Const 
	mov qword [fvar_tbl+387*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3588 ; Const 
	mov qword [fvar_tbl+386*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3597 ; Const 
	mov qword [fvar_tbl+385*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3606 ; Const 
	mov qword [fvar_tbl+384*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3615 ; Const 
	mov qword [fvar_tbl+383*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3624 ; Const 
	mov qword [fvar_tbl+382*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3633 ; Const 
	mov qword [fvar_tbl+381*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3642 ; Const 
	mov qword [fvar_tbl+380*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3651 ; Const 
	mov qword [fvar_tbl+379*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3660 ; Const 
	mov qword [fvar_tbl+378*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3669 ; Const 
	mov qword [fvar_tbl+377*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3678 ; Const 
	mov qword [fvar_tbl+376*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3687 ; Const 
	mov qword [fvar_tbl+375*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3696 ; Const 
	mov qword [fvar_tbl+374*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3705 ; Const 
	mov qword [fvar_tbl+373*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3714 ; Const 
	mov qword [fvar_tbl+372*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3723 ; Const 
	mov qword [fvar_tbl+371*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3732 ; Const 
	mov qword [fvar_tbl+370*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3741 ; Const 
	mov qword [fvar_tbl+369*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3750 ; Const 
	mov qword [fvar_tbl+368*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3759 ; Const 
	mov qword [fvar_tbl+367*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3768 ; Const 
	mov qword [fvar_tbl+366*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3777 ; Const 
	mov qword [fvar_tbl+365*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3786 ; Const 
	mov qword [fvar_tbl+364*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3795 ; Const 
	mov qword [fvar_tbl+363*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3804 ; Const 
	mov qword [fvar_tbl+362*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3813 ; Const 
	mov qword [fvar_tbl+361*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3822 ; Const 
	mov qword [fvar_tbl+360*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3831 ; Const 
	mov qword [fvar_tbl+359*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3840 ; Const 
	mov qword [fvar_tbl+358*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3849 ; Const 
	mov qword [fvar_tbl+357*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3858 ; Const 
	mov qword [fvar_tbl+356*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3867 ; Const 
	mov qword [fvar_tbl+355*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3876 ; Const 
	mov qword [fvar_tbl+354*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3885 ; Const 
	mov qword [fvar_tbl+353*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3894 ; Const 
	mov qword [fvar_tbl+352*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3903 ; Const 
	mov qword [fvar_tbl+351*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3912 ; Const 
	mov qword [fvar_tbl+350*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3921 ; Const 
	mov qword [fvar_tbl+349*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3930 ; Const 
	mov qword [fvar_tbl+348*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3939 ; Const 
	mov qword [fvar_tbl+347*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3948 ; Const 
	mov qword [fvar_tbl+346*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3957 ; Const 
	mov qword [fvar_tbl+345*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3966 ; Const 
	mov qword [fvar_tbl+344*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3975 ; Const 
	mov qword [fvar_tbl+343*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3984 ; Const 
	mov qword [fvar_tbl+342*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+3993 ; Const 
	mov qword [fvar_tbl+341*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4002 ; Const 
	mov qword [fvar_tbl+340*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4011 ; Const 
	mov qword [fvar_tbl+339*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4020 ; Const 
	mov qword [fvar_tbl+338*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4029 ; Const 
	mov qword [fvar_tbl+337*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4038 ; Const 
	mov qword [fvar_tbl+336*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4047 ; Const 
	mov qword [fvar_tbl+335*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4056 ; Const 
	mov qword [fvar_tbl+334*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4065 ; Const 
	mov qword [fvar_tbl+333*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4074 ; Const 
	mov qword [fvar_tbl+332*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4083 ; Const 
	mov qword [fvar_tbl+331*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4092 ; Const 
	mov qword [fvar_tbl+330*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4101 ; Const 
	mov qword [fvar_tbl+329*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4110 ; Const 
	mov qword [fvar_tbl+328*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4119 ; Const 
	mov qword [fvar_tbl+327*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4128 ; Const 
	mov qword [fvar_tbl+326*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4137 ; Const 
	mov qword [fvar_tbl+325*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4146 ; Const 
	mov qword [fvar_tbl+324*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4155 ; Const 
	mov qword [fvar_tbl+323*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4164 ; Const 
	mov qword [fvar_tbl+322*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4173 ; Const 
	mov qword [fvar_tbl+321*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4182 ; Const 
	mov qword [fvar_tbl+320*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4191 ; Const 
	mov qword [fvar_tbl+319*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4200 ; Const 
	mov qword [fvar_tbl+318*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4209 ; Const 
	mov qword [fvar_tbl+317*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4218 ; Const 
	mov qword [fvar_tbl+316*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4227 ; Const 
	mov qword [fvar_tbl+315*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4236 ; Const 
	mov qword [fvar_tbl+314*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4245 ; Const 
	mov qword [fvar_tbl+313*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4254 ; Const 
	mov qword [fvar_tbl+312*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4263 ; Const 
	mov qword [fvar_tbl+311*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4272 ; Const 
	mov qword [fvar_tbl+310*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4281 ; Const 
	mov qword [fvar_tbl+309*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4290 ; Const 
	mov qword [fvar_tbl+308*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4299 ; Const 
	mov qword [fvar_tbl+307*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4308 ; Const 
	mov qword [fvar_tbl+306*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4317 ; Const 
	mov qword [fvar_tbl+305*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4326 ; Const 
	mov qword [fvar_tbl+304*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4335 ; Const 
	mov qword [fvar_tbl+303*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4344 ; Const 
	mov qword [fvar_tbl+302*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4353 ; Const 
	mov qword [fvar_tbl+301*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4362 ; Const 
	mov qword [fvar_tbl+300*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4371 ; Const 
	mov qword [fvar_tbl+299*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4380 ; Const 
	mov qword [fvar_tbl+298*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4389 ; Const 
	mov qword [fvar_tbl+297*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4398 ; Const 
	mov qword [fvar_tbl+296*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4407 ; Const 
	mov qword [fvar_tbl+295*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4416 ; Const 
	mov qword [fvar_tbl+294*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4425 ; Const 
	mov qword [fvar_tbl+293*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4434 ; Const 
	mov qword [fvar_tbl+292*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4443 ; Const 
	mov qword [fvar_tbl+291*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4452 ; Const 
	mov qword [fvar_tbl+290*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4461 ; Const 
	mov qword [fvar_tbl+289*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4470 ; Const 
	mov qword [fvar_tbl+288*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4479 ; Const 
	mov qword [fvar_tbl+287*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4488 ; Const 
	mov qword [fvar_tbl+286*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4497 ; Const 
	mov qword [fvar_tbl+285*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4506 ; Const 
	mov qword [fvar_tbl+284*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4515 ; Const 
	mov qword [fvar_tbl+283*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4524 ; Const 
	mov qword [fvar_tbl+282*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4533 ; Const 
	mov qword [fvar_tbl+281*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4542 ; Const 
	mov qword [fvar_tbl+280*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4551 ; Const 
	mov qword [fvar_tbl+279*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4560 ; Const 
	mov qword [fvar_tbl+278*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4569 ; Const 
	mov qword [fvar_tbl+277*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4578 ; Const 
	mov qword [fvar_tbl+276*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4587 ; Const 
	mov qword [fvar_tbl+275*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4596 ; Const 
	mov qword [fvar_tbl+274*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4605 ; Const 
	mov qword [fvar_tbl+273*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4614 ; Const 
	mov qword [fvar_tbl+272*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4623 ; Const 
	mov qword [fvar_tbl+271*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4632 ; Const 
	mov qword [fvar_tbl+270*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4641 ; Const 
	mov qword [fvar_tbl+269*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4650 ; Const 
	mov qword [fvar_tbl+268*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4659 ; Const 
	mov qword [fvar_tbl+267*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4668 ; Const 
	mov qword [fvar_tbl+266*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4677 ; Const 
	mov qword [fvar_tbl+265*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4686 ; Const 
	mov qword [fvar_tbl+264*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4695 ; Const 
	mov qword [fvar_tbl+263*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4704 ; Const 
	mov qword [fvar_tbl+262*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4713 ; Const 
	mov qword [fvar_tbl+261*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4722 ; Const 
	mov qword [fvar_tbl+260*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4731 ; Const 
	mov qword [fvar_tbl+259*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4740 ; Const 
	mov qword [fvar_tbl+258*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4749 ; Const 
	mov qword [fvar_tbl+257*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4758 ; Const 
	mov qword [fvar_tbl+256*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4767 ; Const 
	mov qword [fvar_tbl+255*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4776 ; Const 
	mov qword [fvar_tbl+254*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4785 ; Const 
	mov qword [fvar_tbl+253*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4794 ; Const 
	mov qword [fvar_tbl+252*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4803 ; Const 
	mov qword [fvar_tbl+251*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4812 ; Const 
	mov qword [fvar_tbl+250*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4821 ; Const 
	mov qword [fvar_tbl+249*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4830 ; Const 
	mov qword [fvar_tbl+248*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4839 ; Const 
	mov qword [fvar_tbl+247*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4848 ; Const 
	mov qword [fvar_tbl+246*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4857 ; Const 
	mov qword [fvar_tbl+245*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4866 ; Const 
	mov qword [fvar_tbl+244*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4875 ; Const 
	mov qword [fvar_tbl+243*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4884 ; Const 
	mov qword [fvar_tbl+242*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4893 ; Const 
	mov qword [fvar_tbl+241*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4902 ; Const 
	mov qword [fvar_tbl+240*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4911 ; Const 
	mov qword [fvar_tbl+239*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4920 ; Const 
	mov qword [fvar_tbl+238*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4929 ; Const 
	mov qword [fvar_tbl+237*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4938 ; Const 
	mov qword [fvar_tbl+236*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4947 ; Const 
	mov qword [fvar_tbl+235*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4956 ; Const 
	mov qword [fvar_tbl+234*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4965 ; Const 
	mov qword [fvar_tbl+233*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4974 ; Const 
	mov qword [fvar_tbl+232*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4983 ; Const 
	mov qword [fvar_tbl+231*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+4992 ; Const 
	mov qword [fvar_tbl+230*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5001 ; Const 
	mov qword [fvar_tbl+229*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5010 ; Const 
	mov qword [fvar_tbl+228*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5019 ; Const 
	mov qword [fvar_tbl+227*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5028 ; Const 
	mov qword [fvar_tbl+226*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5037 ; Const 
	mov qword [fvar_tbl+225*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5046 ; Const 
	mov qword [fvar_tbl+224*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5055 ; Const 
	mov qword [fvar_tbl+223*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5064 ; Const 
	mov qword [fvar_tbl+222*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5073 ; Const 
	mov qword [fvar_tbl+221*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5082 ; Const 
	mov qword [fvar_tbl+220*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5091 ; Const 
	mov qword [fvar_tbl+219*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5100 ; Const 
	mov qword [fvar_tbl+218*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5109 ; Const 
	mov qword [fvar_tbl+217*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5118 ; Const 
	mov qword [fvar_tbl+216*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5127 ; Const 
	mov qword [fvar_tbl+215*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5136 ; Const 
	mov qword [fvar_tbl+214*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5145 ; Const 
	mov qword [fvar_tbl+213*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5154 ; Const 
	mov qword [fvar_tbl+212*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5163 ; Const 
	mov qword [fvar_tbl+211*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5172 ; Const 
	mov qword [fvar_tbl+210*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5181 ; Const 
	mov qword [fvar_tbl+209*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5190 ; Const 
	mov qword [fvar_tbl+208*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5199 ; Const 
	mov qword [fvar_tbl+207*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5208 ; Const 
	mov qword [fvar_tbl+206*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5217 ; Const 
	mov qword [fvar_tbl+205*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5226 ; Const 
	mov qword [fvar_tbl+204*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5235 ; Const 
	mov qword [fvar_tbl+203*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5244 ; Const 
	mov qword [fvar_tbl+202*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5253 ; Const 
	mov qword [fvar_tbl+201*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5262 ; Const 
	mov qword [fvar_tbl+200*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5271 ; Const 
	mov qword [fvar_tbl+199*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5280 ; Const 
	mov qword [fvar_tbl+198*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5289 ; Const 
	mov qword [fvar_tbl+197*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5298 ; Const 
	mov qword [fvar_tbl+196*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5307 ; Const 
	mov qword [fvar_tbl+195*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5316 ; Const 
	mov qword [fvar_tbl+194*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5325 ; Const 
	mov qword [fvar_tbl+193*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5334 ; Const 
	mov qword [fvar_tbl+192*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5343 ; Const 
	mov qword [fvar_tbl+191*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5352 ; Const 
	mov qword [fvar_tbl+190*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5361 ; Const 
	mov qword [fvar_tbl+189*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5370 ; Const 
	mov qword [fvar_tbl+188*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5379 ; Const 
	mov qword [fvar_tbl+187*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5388 ; Const 
	mov qword [fvar_tbl+186*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5397 ; Const 
	mov qword [fvar_tbl+185*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5406 ; Const 
	mov qword [fvar_tbl+184*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5415 ; Const 
	mov qword [fvar_tbl+183*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5424 ; Const 
	mov qword [fvar_tbl+182*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5433 ; Const 
	mov qword [fvar_tbl+181*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5442 ; Const 
	mov qword [fvar_tbl+180*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5451 ; Const 
	mov qword [fvar_tbl+179*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5460 ; Const 
	mov qword [fvar_tbl+178*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5469 ; Const 
	mov qword [fvar_tbl+177*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5478 ; Const 
	mov qword [fvar_tbl+176*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5487 ; Const 
	mov qword [fvar_tbl+175*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5496 ; Const 
	mov qword [fvar_tbl+174*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5505 ; Const 
	mov qword [fvar_tbl+173*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5514 ; Const 
	mov qword [fvar_tbl+172*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5523 ; Const 
	mov qword [fvar_tbl+171*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5532 ; Const 
	mov qword [fvar_tbl+170*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5541 ; Const 
	mov qword [fvar_tbl+169*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5550 ; Const 
	mov qword [fvar_tbl+168*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5559 ; Const 
	mov qword [fvar_tbl+167*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5568 ; Const 
	mov qword [fvar_tbl+166*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5577 ; Const 
	mov qword [fvar_tbl+165*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5586 ; Const 
	mov qword [fvar_tbl+164*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5595 ; Const 
	mov qword [fvar_tbl+163*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5604 ; Const 
	mov qword [fvar_tbl+162*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5613 ; Const 
	mov qword [fvar_tbl+161*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5622 ; Const 
	mov qword [fvar_tbl+160*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5631 ; Const 
	mov qword [fvar_tbl+159*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5640 ; Const 
	mov qword [fvar_tbl+158*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5649 ; Const 
	mov qword [fvar_tbl+157*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5658 ; Const 
	mov qword [fvar_tbl+156*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5667 ; Const 
	mov qword [fvar_tbl+155*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5676 ; Const 
	mov qword [fvar_tbl+154*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5685 ; Const 
	mov qword [fvar_tbl+153*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5694 ; Const 
	mov qword [fvar_tbl+152*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5703 ; Const 
	mov qword [fvar_tbl+151*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5712 ; Const 
	mov qword [fvar_tbl+150*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5721 ; Const 
	mov qword [fvar_tbl+149*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5730 ; Const 
	mov qword [fvar_tbl+148*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5739 ; Const 
	mov qword [fvar_tbl+147*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5748 ; Const 
	mov qword [fvar_tbl+146*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5757 ; Const 
	mov qword [fvar_tbl+145*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5766 ; Const 
	mov qword [fvar_tbl+144*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5775 ; Const 
	mov qword [fvar_tbl+143*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5784 ; Const 
	mov qword [fvar_tbl+142*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5793 ; Const 
	mov qword [fvar_tbl+141*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5802 ; Const 
	mov qword [fvar_tbl+140*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5811 ; Const 
	mov qword [fvar_tbl+139*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5820 ; Const 
	mov qword [fvar_tbl+138*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5829 ; Const 
	mov qword [fvar_tbl+137*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5838 ; Const 
	mov qword [fvar_tbl+136*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5847 ; Const 
	mov qword [fvar_tbl+135*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5856 ; Const 
	mov qword [fvar_tbl+134*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5865 ; Const 
	mov qword [fvar_tbl+133*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5874 ; Const 
	mov qword [fvar_tbl+132*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5883 ; Const 
	mov qword [fvar_tbl+131*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5892 ; Const 
	mov qword [fvar_tbl+130*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5901 ; Const 
	mov qword [fvar_tbl+129*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5910 ; Const 
	mov qword [fvar_tbl+128*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5919 ; Const 
	mov qword [fvar_tbl+127*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5928 ; Const 
	mov qword [fvar_tbl+126*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5937 ; Const 
	mov qword [fvar_tbl+125*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5946 ; Const 
	mov qword [fvar_tbl+124*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5955 ; Const 
	mov qword [fvar_tbl+123*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5964 ; Const 
	mov qword [fvar_tbl+122*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5973 ; Const 
	mov qword [fvar_tbl+121*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5982 ; Const 
	mov qword [fvar_tbl+120*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+5991 ; Const 
	mov qword [fvar_tbl+119*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6000 ; Const 
	mov qword [fvar_tbl+118*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6009 ; Const 
	mov qword [fvar_tbl+117*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6018 ; Const 
	mov qword [fvar_tbl+116*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6027 ; Const 
	mov qword [fvar_tbl+115*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6036 ; Const 
	mov qword [fvar_tbl+114*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6045 ; Const 
	mov qword [fvar_tbl+113*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6054 ; Const 
	mov qword [fvar_tbl+112*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6063 ; Const 
	mov qword [fvar_tbl+111*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6072 ; Const 
	mov qword [fvar_tbl+110*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6081 ; Const 
	mov qword [fvar_tbl+109*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6090 ; Const 
	mov qword [fvar_tbl+108*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6099 ; Const 
	mov qword [fvar_tbl+107*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6108 ; Const 
	mov qword [fvar_tbl+106*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6117 ; Const 
	mov qword [fvar_tbl+105*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6126 ; Const 
	mov qword [fvar_tbl+104*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6135 ; Const 
	mov qword [fvar_tbl+103*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6144 ; Const 
	mov qword [fvar_tbl+102*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6153 ; Const 
	mov qword [fvar_tbl+101*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6162 ; Const 
	mov qword [fvar_tbl+100*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6171 ; Const 
	mov qword [fvar_tbl+99*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6180 ; Const 
	mov qword [fvar_tbl+98*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6189 ; Const 
	mov qword [fvar_tbl+97*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6198 ; Const 
	mov qword [fvar_tbl+96*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6207 ; Const 
	mov qword [fvar_tbl+95*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6216 ; Const 
	mov qword [fvar_tbl+94*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6225 ; Const 
	mov qword [fvar_tbl+93*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6234 ; Const 
	mov qword [fvar_tbl+92*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6243 ; Const 
	mov qword [fvar_tbl+91*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6252 ; Const 
	mov qword [fvar_tbl+90*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6261 ; Const 
	mov qword [fvar_tbl+89*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6270 ; Const 
	mov qword [fvar_tbl+88*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6279 ; Const 
	mov qword [fvar_tbl+87*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6288 ; Const 
	mov qword [fvar_tbl+86*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6297 ; Const 
	mov qword [fvar_tbl+85*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6306 ; Const 
	mov qword [fvar_tbl+84*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6315 ; Const 
	mov qword [fvar_tbl+83*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6324 ; Const 
	mov qword [fvar_tbl+82*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6333 ; Const 
	mov qword [fvar_tbl+81*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6342 ; Const 
	mov qword [fvar_tbl+80*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6351 ; Const 
	mov qword [fvar_tbl+79*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6360 ; Const 
	mov qword [fvar_tbl+78*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6369 ; Const 
	mov qword [fvar_tbl+77*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6378 ; Const 
	mov qword [fvar_tbl+76*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6387 ; Const 
	mov qword [fvar_tbl+75*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6396 ; Const 
	mov qword [fvar_tbl+74*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6405 ; Const 
	mov qword [fvar_tbl+73*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6414 ; Const 
	mov qword [fvar_tbl+72*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6423 ; Const 
	mov qword [fvar_tbl+71*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6432 ; Const 
	mov qword [fvar_tbl+70*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6441 ; Const 
	mov qword [fvar_tbl+69*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6450 ; Const 
	mov qword [fvar_tbl+68*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6459 ; Const 
	mov qword [fvar_tbl+67*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6468 ; Const 
	mov qword [fvar_tbl+66*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6477 ; Const 
	mov qword [fvar_tbl+65*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6486 ; Const 
	mov qword [fvar_tbl+64*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6495 ; Const 
	mov qword [fvar_tbl+63*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6504 ; Const 
	mov qword [fvar_tbl+62*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6513 ; Const 
	mov qword [fvar_tbl+61*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6522 ; Const 
	mov qword [fvar_tbl+60*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6531 ; Const 
	mov qword [fvar_tbl+59*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6540 ; Const 
	mov qword [fvar_tbl+58*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6549 ; Const 
	mov qword [fvar_tbl+57*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6558 ; Const 
	mov qword [fvar_tbl+56*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6567 ; Const 
	mov qword [fvar_tbl+55*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6576 ; Const 
	mov qword [fvar_tbl+54*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6585 ; Const 
	mov qword [fvar_tbl+53*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6594 ; Const 
	mov qword [fvar_tbl+52*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6603 ; Const 
	mov qword [fvar_tbl+51*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6612 ; Const 
	mov qword [fvar_tbl+50*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6621 ; Const 
	mov qword [fvar_tbl+49*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6630 ; Const 
	mov qword [fvar_tbl+48*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6639 ; Const 
	mov qword [fvar_tbl+47*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6648 ; Const 
	mov qword [fvar_tbl+46*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6657 ; Const 
	mov qword [fvar_tbl+45*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6666 ; Const 
	mov qword [fvar_tbl+44*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6675 ; Const 
	mov qword [fvar_tbl+43*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6684 ; Const 
	mov qword [fvar_tbl+42*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6693 ; Const 
	mov qword [fvar_tbl+41*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6702 ; Const 
	mov qword [fvar_tbl+40*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6711 ; Const 
	mov qword [fvar_tbl+39*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6720 ; Const 
	mov qword [fvar_tbl+38*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6729 ; Const 
	mov qword [fvar_tbl+37*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6738 ; Const 
	mov qword [fvar_tbl+36*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6747 ; Const 
	mov qword [fvar_tbl+35*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void

	mov rax, const_tbl+6756 ; Const 
	mov qword [fvar_tbl+34*WORD_SIZE], rax ; VarFree, Set 
	mov rax, SOB_VOID_ADDRESS
	call write_sob_if_not_void
	add rsp, 4*8 
	pop rbp 
	ret 


apply:
    push rbp
    mov rbp, rsp
    
    mov rcx, 2 ; Magic Loc >= 2

.get_list:
    mov r14, PVAR(rcx) 
    cmp r14, 6666
    je .got_list ; If Magic, Got List
    inc rcx
    jmp .get_list 

.got_list:
    dec rcx ; Last Elem Idx
    mov r14, PVAR(rcx) ; List
    mov r11, r14 ; Init
    mov rdx, 1 ; Init <lenList>
    push 6666 ; Magic

.push_list:
    cmp r11, const_tbl+1 ; Nil is Last Item
    je .prep_swap ; Reach Last Item
	CAR r10, r14 ; CurrCar
    CDR r11, r14 ; CurrCdr
    push r10 ; Push Car
    mov r14, r11 ; currList
    inc rdx ; <nOptListElems> ++
    jmp .push_list

.prep_swap:
    mov r10, rsp ; Prepare to Reverse List
    mov r11, rbp
    add r11, -16 ; By Swaps

.reverse:
    cmp r10, r11 ; Check If Pass All Elems
    jg .finish
    mov r12, qword[r10] ; Swap [r10], [r11]
    mov r13, qword[r11]
    mov qword[r10], r13
    mov qword[r11], r12
    add r10, 8 ; Inc To Next Loc
    add r11, -8 ; Dec To Next Loc
    jmp .reverse

.finish:
    dec rcx ; <LastElemIdx> - 1 = <nArgs>
    add rdx, rcx ; oldLen + listLen
    dec rdx ; oldLen + listLen - 1
    
    cmp rcx, 0 ; <nArgs>
    jle .prep_call ; Check If No Args Before List

.push_args:
    mov rax, PVAR(rcx) 
    push rax 
    cmp rcx, 1
    je .prep_call
    dec rcx
    jmp .push_args

.prep_call:
    push rdx ; <newNumArgs>
    mov rax, PVAR(0) ; #<Procedure>
    mov r9, [rax + TYPE_SIZE] ; Env 
    push r9 
    mov r10, [rax + TYPE_SIZE + WORD_SIZE] ; Code 
    push qword [rbp + 8] ; Old Ret Addr
    mov r15, qword [rbp] ; Save rbp
    add rdx, 5 ; <newLen> + 5
    
    ; Macro Shift_Frame
	push rax
	mov r9, PARAM_COUNT ; prevLen
	mov rax, r9
	add rax, 5
    mov r11, 1
    
.shift: ; # <rdx> times
	dec rax
    mov r12, r11 ; idxLoop
    shl r12, 3 ; idxLoop * 8
    mov r13, rbp
    sub r13, r12 ; rbp - 8 * idxLoop
    mov r8, qword[r13] ; Shift
	mov [rbp + WORD_SIZE * rax], r8
    cmp r11, rdx ; Check If Idx Reach # <rdx>
    je .end_shift
    inc r11
    jmp .shift

.end_shift:
	pop rax
	mov r8, r9 ; PrevLen
	add r8, 5 ; PrevLen + 5
	shl r8, 3 ; (PrevLen + 5) * 8
	add rsp, r8 ; End Macro

    mov rbp, r15 ; Restore rbp
    jmp r10 ; Code
  
.return:
    leave
    ret


is_boolean:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_BOOL
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_float:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_FLOAT
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_integer:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_INTEGER
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_pair:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_PAIR
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_null:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_NIL
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_char:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_CHAR
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_vector:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_VECTOR
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_string:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_STRING
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_procedure:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_CLOSURE
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_symbol:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_SYMBOL
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

string_length:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    STRING_LENGTH rsi, rsi
    MAKE_INT(rax, rsi)

    leave
    ret

string_ref:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) 
    STRING_ELEMENTS rsi, rsi
    mov rdi, PVAR(1)
    INT_VAL rdi, rdi
    shl rdi, 0
    add rsi, rdi

    mov sil, byte [rsi]
    MAKE_CHAR(rax, sil)

    leave
    ret

string_set:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) 
    STRING_ELEMENTS rsi, rsi
    mov rdi, PVAR(1)
    INT_VAL rdi, rdi
    shl rdi, 0
    add rsi, rdi

    mov rax, PVAR(2)
    CHAR_VAL rax, rax
    mov byte [rsi], al
    mov rax, SOB_VOID_ADDRESS

    leave
    ret

make_string:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    mov rdi, PVAR(1)
    CHAR_VAL rdi, rdi
    and rdi, 255

    MAKE_STRING rax, rsi, dil

    leave
    ret

vector_length:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    VECTOR_LENGTH rsi, rsi
    MAKE_INT(rax, rsi)

    leave
    ret

vector_ref:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) 
    VECTOR_ELEMENTS rsi, rsi
    mov rdi, PVAR(1)
    INT_VAL rdi, rdi
    shl rdi, 3
    add rsi, rdi

    mov rax, [rsi]

    leave
    ret

vector_set:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) 
    VECTOR_ELEMENTS rsi, rsi
    mov rdi, PVAR(1)
    INT_VAL rdi, rdi
    shl rdi, 3
    add rsi, rdi

    mov rdi, PVAR(2)
    mov [rsi], rdi
    mov rax, SOB_VOID_ADDRESS

    leave
    ret

make_vector:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    mov rdi, PVAR(1)
    

    MAKE_VECTOR rax, rsi, rdi

    leave
    ret

symbol_to_string:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    SYMBOL_VAL rsi, rsi
    
    STRING_LENGTH rcx, rsi
    STRING_ELEMENTS rdi, rsi

    push rcx
    push rdi

    mov dil, byte [rdi]
    MAKE_CHAR(rax, dil)
    push rax
    MAKE_INT(rax, rcx)
    push rax
    push 2
    push SOB_NIL_ADDRESS
    call make_string
    add rsp, 4*8

    STRING_ELEMENTS rsi, rax

    pop rdi
    pop rcx

.loop:
    cmp rcx, 0
    je .end
    lea r8, [rdi+rcx]
    lea r9, [rsi+rcx]

    mov bl, byte [r8]
    mov byte [r9], bl
    
    dec rcx
.end:

    leave
    ret

char_to_integer:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    CHAR_VAL rsi, rsi
    and rsi, 255
    MAKE_INT(rax, rsi)

    leave
    ret

integer_to_char:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    and rsi, 255
    MAKE_CHAR(rax, sil)

    leave
    ret

is_eq:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    mov rdi, PVAR(1)
    cmp rsi, rdi
    je .true
    mov rax, SOB_FALSE_ADDRESS
    jmp .return

.true:
    mov rax, SOB_TRUE_ADDRESS

.return:
    leave
    ret

bin_add:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    addsd xmm0, xmm1

    pop r8
    cmp r8, 3
    jne .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    leave
    ret

bin_mul:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    mulsd xmm0, xmm1

    pop r8
    cmp r8, 3
    jne .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    leave
    ret

bin_sub:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    subsd xmm0, xmm1

    pop r8
    cmp r8, 3
    jne .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    leave
    ret

bin_div:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    divsd xmm0, xmm1

    pop r8
    cmp r8, 3
    jne .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    leave
    ret

bin_lt:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    cmpltsd xmm0, xmm1

    pop r8
    cmp r8, 3
    jne .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    INT_VAL rsi, rax
    cmp rsi, 0
    je .return_false
    mov rax, SOB_TRUE_ADDRESS
    jmp .final_return

.return_false:
    mov rax, SOB_FALSE_ADDRESS

.final_return:


    leave
    ret

bin_equ:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    cmpeqsd xmm0, xmm1

    pop r8
    cmp r8, 3
    jne .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    INT_VAL rsi, rax
    cmp rsi, 0
    je .return_false
    mov rax, SOB_TRUE_ADDRESS
    jmp .final_return

.return_false:
    mov rax, SOB_FALSE_ADDRESS

.final_return:


    leave
    ret


 
car:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) ; rsi got pair
	CAR rax, rsi ; rax got car
    jmp .return

.return:
    leave
    ret

cdr:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
	CDR rax, rsi
    jmp .return

.return:
    leave
    ret
    
set_car:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(1) ; rsi got new car
    mov r8, PVAR(0) ; qword of pair
    add r8, 1 ; r8 is car loc
    mov [r8], rsi
    mov r9, qword [r8] ; r9 is car val

    mov rax, SOB_VOID_ADDRESS
    jmp .return

.return:
    leave
    ret

set_cdr:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(1) ; rsi got new car
    mov r8, PVAR(0) ; qword of pair
    add r8, 9 ; r8 is cdr loc
    mov [r8], rsi
    mov r9, qword [r8] ; r9 is car val

    mov rax, SOB_VOID_ADDRESS
    jmp .return

.return:
    leave
    ret

cons:
    push rbp
    mov rbp, rsp

    mov r8, PVAR(0) ; car
    mov r9, PVAR(1) ; cdr
    MAKE_PAIR (rax, r8, r9) ; pair into rax

    jmp .return

.return:
    leave
    ret  
