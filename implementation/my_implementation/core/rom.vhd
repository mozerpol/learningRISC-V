library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.std_logic_unsigned.all;
library mozerpol_lib;
   use mozerpol_lib.mozerpol_pkg.all;

package rom is


   type t_rom  is array (0 to C_ROM_LENGTH-1) of std_logic_vector(31 downto 0);

   constant C_CODE : t_rom := (
      x"80000093",
      x"e0100113",
      x"ffe00193",
      x"00000213",
      x"00100293",
      x"1ff00313",
      x"7ff00393",
      x"80038093",
      x"e0130113",
      x"ffe28193",
      x"00020213",
      x"00118293",
      x"1ff10313",
      x"7ff08393",
      x"7ff08093",
      x"80008093",
      x"80002413",
      x"e0102493",
      x"ffe02513",
      x"00002593",
      x"00102613",
      x"1ff02693",
      x"7ff02713",
      x"8003a413",
      x"e010a493",
      x"ffe62513",
      x"0005a593",
      x"00152613",
      x"1ff32693",
      x"7ff4a713",
      x"7ff72713",
      x"80072713",
      x"80003793",
      x"e0103813",
      x"ffe03893",
      x"00003913",
      x"00103993",
      x"1ff03a13",
      x"7ff03a93",
      x"8003b793",
      x"e010b813",
      x"ffe9b893",
      x"00093913",
      x"0018b993",
      x"1ff33a13",
      x"7ff7ba93",
      x"7ffaba93",
      x"800aba93",
      x"80004b13",
      x"e0104b93",
      x"ffe04c13",
      x"00004c93",
      x"00104d13",
      x"1ff04d93",
      x"7ff04e13",
      x"800e4b13",
      x"e01dcb93",
      x"ffed4c13",
      x"000ccc93",
      x"001c4d13",
      x"1ffbcd93",
      x"7ffb4e13",
      x"7ffe4e13",
      x"800e4e13",
      x"80006e93",
      x"e0106f13",
      x"ffe06f93",
      x"00006093",
      x"00106113",
      x"1ff06193",
      x"7ff06213",
      x"80026e93",
      x"e011ef13",
      x"ffe16f93",
      x"0000e093",
      x"001fe113",
      x"1fff6193",
      x"7ffe6213",
      x"7ff26213",
      x"80026213",
      x"80007293",
      x"e0107313",
      x"ffe07393",
      x"00007413",
      x"00107493",
      x"1ff07513",
      x"7ff07593",
      x"80027293",
      x"e0157313",
      x"ffee7393",
      x"000df413",
      x"0013f493",
      x"1ff37513",
      x"7ff2f593",
      x"7ff5f593",
      x"8005f593",
      x"00001613",
      x"00101693",
      x"00201713",
      x"00a01793",
      x"01401813",
      x"01f01893",
      x"000d9613",
      x"001e1693",
      x"002a9713",
      x"00ae9793",
      x"01429813",
      x"01f39893",
      x"01f89893",
      x"00089893",
      x"00005913",
      x"00105993",
      x"00205a13",
      x"00a05a93",
      x"01405b13",
      x"01f05b93",
      x"000d5913",
      x"001dd993",
      x"002e5a13",
      x"00aeda93",
      x"014f5b13",
      x"01f3db93",
      x"01fbdb93",
      x"000bdb93",
      x"40005c13",
      x"40105c93",
      x"40205d13",
      x"40a05d93",
      x"41405e13",
      x"41f05e93",
      x"400b5c13",
      x"401adc93",
      x"402a5d13",
      x"40a9dd93",
      x"41495e13",
      x"41f85e93",
      x"41fede93",
      x"400ede93",
      x"01c00f33",
      x"01b00fb3",
      x"01a000b3",
      x"01900133",
      x"018001b3",
      x"01000233",
      x"000002b3",
      x"01e28f33",
      x"005f0fb3",
      x"01b180b3",
      x"01c10133",
      x"01d081b3",
      x"01af8233",
      x"019f02b3",
      x"005282b3",
      x"005282b3",
      x"41c00333",
      x"41b003b3",
      x"41a00433",
      x"419004b3",
      x"41800533",
      x"410005b3",
      x"40000633",
      x"40678333",
      x"405803b3",
      x"41c68433",
      x"41b604b3",
      x"41a50533",
      x"419f85b3",
      x"418f0633",
      x"40c60633",
      x"40c60633",
      x"000e16b3",
      x"000d9733",
      x"000d17b3",
      x"000c9833",
      x"000c18b3",
      x"00081933",
      x"000019b3",
      x"006796b3",
      x"00581733",
      x"01c697b3",
      x"01b61833",
      x"01a518b3",
      x"019f9933",
      x"018f19b3",
      x"013999b3",
      x"013999b3",
      x"000e2a33",
      x"000daab3",
      x"000d2b33",
      x"000cabb3",
      x"000c2c33",
      x"00082cb3",
      x"00002d33",
      x"0067aa33",
      x"00582ab3",
      x"01c6ab33",
      x"01b62bb3",
      x"01a52c33",
      x"019facb3",
      x"018f2d33",
      x"014a2a33",
      x"014a2a33",
      x"0000bdb3",
      x"00013e33",
      x"0001beb3",
      x"00023f33",
      x"0002bfb3",
      x"000330b3",
      x"00003133",
      x"0060bdb3",
      x"00513e33",
      x"01c1beb3",
      x"01b23f33",
      x"01a2bfb3",
      x"019330b3",
      x"0183b133",
      x"00213133",
      x"00213133",
      x"00b541b3",
      x"00a5c233",
      x"008742b3",
      x"00e3c333",
      x"0082c3b3",
      x"00034433",
      x"000044b3",
      x"006341b3",
      x"00b2c233",
      x"00a3c2b3",
      x"0085c333",
      x"00e743b3",
      x"00d54433",
      x"0032c4b3",
      x"0094c4b3",
      x"0094c4b3",
      x"00b55533",
      x"00a5d5b3",
      x"00875633",
      x"00e3d6b3",
      x"0082d733",
      x"000357b3",
      x"00005833",
      x"00655533",
      x"00b5d5b3",
      x"00a15633",
      x"0086d6b3",
      x"00e75733",
      x"00d7d7b3",
      x"00385833",
      x"01085833",
      x"01085833",
      x"406258b3",
      x"40435933",
      x"408359b3",
      x"4093da33",
      x"41345ab3",
      x"4054db33",
      x"40055bb3",
      x"405358b3",
      x"40b3d933",
      x"40a459b3",
      x"4084da33",
      x"40e75ab3",
      x"40d7db33",
      x"40385bb3",
      x"417bdbb3",
      x"417bdbb3",
      x"00826c33",
      x"00446cb3",
      x"00036d33",
      x"00a3edb3",
      x"01346e33",
      x"00556eb3",
      x"0005ef33",
      x"00536c33",
      x"00b3ecb3",
      x"00a46d33",
      x"00856db3",
      x"00e5ee33",
      x"00d86eb3",
      x"0057ef33",
      x"01ef6f33",
      x"01ef6f33",
      x"00627fb3",
      x"004370b3",
      x"00837133",
      x"009571b3",
      x"01347233",
      x"0055f2b3",
      x"00057fb3",
      x"005370b3",
      x"00b3f133",
      x"00a471b3",
      x"0082f233",
      x"00e772b3",
      x"00d87333",
      x"0047f3b3",
      x"0073f3b3",
      x"0073f3b3",
      x"00000417",
      x"00000497",
      x"40848533",
      x"00000597",
      x"fffff617",
      x"40b606b3",
      x"00000717",
      x"00800797",
      x"40e78833",
      x"00000897",
      x"00001917",
      x"411909b3",
      x"00000837",
      x"fffff8b7",
      x"7ffff937",
      x"004009b7",
      x"00200a37",
      x"00200a37",
      x"00001ab7",
      x"00100093",
      x"00200113",
      x"fff00193",
      x"0ff00213",
      x"00400293",
      x"ffc00393",
      x"ff800413",
      x"00000493",
      x"00000013",
      x"fe418ee3",
      x"00000517",
      x"02900063",
      x"00108093",
      x"00000697",
      x"40b68733",
      x"00728e63",
      x"00000797",
      x"40d78833",
      x"00048863",
      x"00000597",
      x"40a58633",
      x"fe9000e3",
      x"00000897",
      x"40f88933",
      x"00108093",
      x"00000093",
      x"00000997",
      x"02419063",
      x"00000b17",
      x"414b0bb3",
      x"00108093",
      x"00049e63",
      x"00000c17",
      x"416c0cb3",
      x"00839863",
      x"00000a17",
      x"413a0ab3",
      x"fc729ee3",
      x"00000d17",
      x"418d0db3",
      x"00000093",
      x"00000e17",
      x"0041cc63",
      x"00000f97",
      x"41ef8533",
      x"0283c463",
      x"00108093",
      x"0211c063",
      x"00000e97",
      x"41ce8f33",
      x"fe3242e3",
      x"00108093",
      x"fc04cee3",
      x"00108093",
      x"fc744ae3",
      x"00000597",
      x"40a58633",
      x"00000093",
      x"00000697",
      x"00325c63",
      x"00000817",
      x"40f808b3",
      x"02745463",
      x"00108093",
      x"0230d063",
      x"00000717",
      x"40d707b3",
      x"fe41d2e3",
      x"00108093",
      x"fc43dee3",
      x"00108093",
      x"fc905ae3",
      x"00000917",
      x"41190633",
      x"00000093",
      x"00000a17",
      x"02746063",
      x"00000b97",
      x"416b8c33",
      x"0204e063",
      x"00108093",
      x"0041ec63",
      x"00108093",
      x"00326863",
      x"00000a97",
      x"414a8b33",
      x"fc746ee3",
      x"00000c97",
      x"418c8d33",
      x"00000093",
      x"00000d97",
      x"0283f063",
      x"00000e17",
      x"41be0eb3",
      x"02717063",
      x"00108093",
      x"00327c63",
      x"00108093",
      x"0041f863",
      x"00000f17",
      x"41df0fb3",
      x"fc83fee3",
      x"00000517",
      x"41f505b3",
      x"00000093",
      x"00000617",
      x"010006ef",
      x"00108093",
      x"00108093",
      x"010007ef",
      x"00108093",
      x"00108093",
      x"fedff76f",
      x"00108093",
      x"00000817",
      x"40f808b3",
      x"00000093",
      x"00000917",
      x"008909e7",
      x"00000013",
      x"01c90a67",
      x"00000013",
      x"00000b97",
      x"010b8c67",
      x"00000a97",
      x"ff4a8b67",
      x"00000013",
      x"00000013",
      x"00100093",
      x"00200113",
      x"00000193",
      x"4d200213",
      x"0ab00293",
      x"0cd00313",
      x"c0000393",
      x"abcde437",
      x"0f140413",
      x"123454b7",
      x"67848493",
      x"00900023",
      x"009000a3",
      x"009080a3",
      x"009100a3",
      x"00910123",
      x"fe808fa3",
      x"fe810fa3",
      x"fe810f23",
      x"00800523",
      x"00808823",
      x"01e01023",
      x"01e090a3",
      x"01e11123",
      x"fe809fa3",
      x"ffe11f23",
      x"01e01523",
      x"01e11823",
      x"00702023",
      x"00712123",
      x"fe80afa3",
      x"fe712f23",
      x"00008183",
      x"00010203",
      x"00b00283",
      x"fff10383",
      x"ffe50403",
      x"00418603",
      x"00f18683",
      x"00011703",
      x"00a01783",
      x"ffe51803",
      x"00419883",
      x"00212903",
      x"00052983",
      x"ffc52a03",
      x"0041aa83",
      x"00100093",
      x"00200113",
      x"00400193",
      x"00800213",
      x"00f00293",
      x"0fb00313",
      x"02000fa3",
      x"0e100fa3",
      x"00230223",
      x"0e300fa3",
      x"0e400fa3",
      x"0e500fa3",
      x"0e000fa3",
      others => x"00000000"
      );
end;

package body rom is

end package body;
