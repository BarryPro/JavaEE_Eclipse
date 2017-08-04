<%!
	public static String des(String key, String message, int encrypt, int mode, String iv)
	{
		int spfunction1[] = {
			0x1010400, 0, 0x10000, 0x1010404, 0x1010004, 0x10404, 4, 0x10000, 1024, 0x1010400, 
			0x1010404, 1024, 0x1000404, 0x1010004, 0x1000000, 4, 1028, 0x1000400, 0x1000400, 0x10400, 
			0x10400, 0x1010000, 0x1010000, 0x1000404, 0x10004, 0x1000004, 0x1000004, 0x10004, 0, 1028, 
			0x10404, 0x1000000, 0x10000, 0x1010404, 4, 0x1010000, 0x1010400, 0x1000000, 0x1000000, 1024, 
			0x1010004, 0x10000, 0x10400, 0x1000004, 1024, 4, 0x1000404, 0x10404, 0x1010404, 0x10004, 
			0x1010000, 0x1000404, 0x1000004, 1028, 0x10404, 0x1010400, 1028, 0x1000400, 0x1000400, 0, 
			0x10004, 0x10400, 0, 0x1010004
		};
		int spfunction2[] = {
			0x80108020, 0x80008000, 32768, 0x108020, 0x100000, 32, 0x80100020, 0x80008020, 0x80000020, 0x80108020, 
			0x80108000, 0x80000000, 0x80008000, 0x100000, 32, 0x80100020, 0x108000, 0x100020, 0x80008020, 0, 
			0x80000000, 32768, 0x108020, 0x80100000, 0x100020, 0x80000020, 0, 0x108000, 32800, 0x80108000, 
			0x80100000, 32800, 0, 0x108020, 0x80100020, 0x100000, 0x80008020, 0x80100000, 0x80108000, 32768, 
			0x80100000, 0x80008000, 32, 0x80108020, 0x108020, 32, 32768, 0x80000000, 32800, 0x80108000, 
			0x100000, 0x80000020, 0x100020, 0x80008020, 0x80000020, 0x100020, 0x108000, 0, 0x80008000, 32800, 
			0x80000000, 0x80100020, 0x80108020, 0x108000
		};
		int spfunction3[] = {
			520, 0x8020200, 0, 0x8020008, 0x8000200, 0, 0x20208, 0x8000200, 0x20008, 0x8000008, 
			0x8000008, 0x20000, 0x8020208, 0x20008, 0x8020000, 520, 0x8000000, 8, 0x8020200, 512, 
			0x20200, 0x8020000, 0x8020008, 0x20208, 0x8000208, 0x20200, 0x20000, 0x8000208, 8, 0x8020208, 
			512, 0x8000000, 0x8020200, 0x8000000, 0x20008, 520, 0x20000, 0x8020200, 0x8000200, 0, 
			512, 0x20008, 0x8020208, 0x8000200, 0x8000008, 512, 0, 0x8020008, 0x8000208, 0x20000, 
			0x8000000, 0x8020208, 8, 0x20208, 0x20200, 0x8000008, 0x8020000, 0x8000208, 520, 0x8020000, 
			0x20208, 8, 0x8020008, 0x20200
		};
		int spfunction4[] = {
			0x802001, 8321, 8321, 128, 0x802080, 0x800081, 0x800001, 8193, 0, 0x802000, 
			0x802000, 0x802081, 129, 0, 0x800080, 0x800001, 1, 8192, 0x800000, 0x802001, 
			128, 0x800000, 8193, 8320, 0x800081, 1, 8320, 0x800080, 8192, 0x802080, 
			0x802081, 129, 0x800080, 0x800001, 0x802000, 0x802081, 129, 0, 0, 0x802000, 
			8320, 0x800080, 0x800081, 1, 0x802001, 8321, 8321, 128, 0x802081, 129, 
			1, 8192, 0x800001, 8193, 0x802080, 0x800081, 8193, 8320, 0x800000, 0x802001, 
			128, 0x800000, 8192, 0x802080
		};
		int spfunction5[] = {
			256, 0x2080100, 0x2080000, 0x42000100, 0x80000, 256, 0x40000000, 0x2080000, 0x40080100, 0x80000, 
			0x2000100, 0x40080100, 0x42000100, 0x42080000, 0x80100, 0x40000000, 0x2000000, 0x40080000, 0x40080000, 0, 
			0x40000100, 0x42080100, 0x42080100, 0x2000100, 0x42080000, 0x40000100, 0, 0x42000000, 0x2080100, 0x2000000, 
			0x42000000, 0x80100, 0x80000, 0x42000100, 256, 0x2000000, 0x40000000, 0x2080000, 0x42000100, 0x40080100, 
			0x2000100, 0x40000000, 0x42080000, 0x2080100, 0x40080100, 256, 0x2000000, 0x42080000, 0x42080100, 0x80100, 
			0x42000000, 0x42080100, 0x2080000, 0, 0x40080000, 0x42000000, 0x80100, 0x2000100, 0x40000100, 0x80000, 
			0, 0x40080000, 0x2080100, 0x40000100
		};
		int spfunction6[] = {
			0x20000010, 0x20400000, 16384, 0x20404010, 0x20400000, 16, 0x20404010, 0x400000, 0x20004000, 0x404010, 
			0x400000, 0x20000010, 0x400010, 0x20004000, 0x20000000, 16400, 0, 0x400010, 0x20004010, 16384, 
			0x404000, 0x20004010, 16, 0x20400010, 0x20400010, 0, 0x404010, 0x20404000, 16400, 0x404000, 
			0x20404000, 0x20000000, 0x20004000, 16, 0x20400010, 0x404000, 0x20404010, 0x400000, 16400, 0x20000010, 
			0x400000, 0x20004000, 0x20000000, 16400, 0x20000010, 0x20404010, 0x404000, 0x20400000, 0x404010, 0x20404000, 
			0, 0x20400010, 16, 16384, 0x20400000, 0x404010, 16384, 0x400010, 0x20004010, 0, 
			0x20404000, 0x20000000, 0x400010, 0x20004010
		};
		int spfunction7[] = {
			0x200000, 0x4200002, 0x4000802, 0, 2048, 0x4000802, 0x200802, 0x4200800, 0x4200802, 0x200000, 
			0, 0x4000002, 2, 0x4000000, 0x4200002, 2050, 0x4000800, 0x200802, 0x200002, 0x4000800, 
			0x4000002, 0x4200000, 0x4200800, 0x200002, 0x4200000, 2048, 2050, 0x4200802, 0x200800, 2, 
			0x4000000, 0x200800, 0x4000000, 0x200800, 0x200000, 0x4000802, 0x4000802, 0x4200002, 0x4200002, 2, 
			0x200002, 0x4000000, 0x4000800, 0x200000, 0x4200800, 2050, 0x200802, 0x4200800, 2050, 0x4000002, 
			0x4200802, 0x4200000, 0x200800, 0, 2, 0x4200802, 0, 0x200802, 0x4200000, 2048, 
			0x4000002, 0x4000800, 2048, 0x200002
		};
		int spfunction8[] = {
			0x10001040, 4096, 0x40000, 0x10041040, 0x10000000, 0x10001040, 64, 0x10000000, 0x40040, 0x10040000, 
			0x10041040, 0x41000, 0x10041000, 0x41040, 4096, 64, 0x10040000, 0x10000040, 0x10001000, 4160, 
			0x41000, 0x40040, 0x10040040, 0x10041000, 4160, 0, 0, 0x10040040, 0x10000040, 0x10001000, 
			0x41040, 0x40000, 0x41040, 0x40000, 0x10041000, 4096, 64, 0x10040040, 4096, 0x41040, 
			0x10001000, 64, 0x10000040, 0x10040000, 0x10040040, 0x10000000, 0x40000, 0x10001040, 0, 0x10041040, 
			0x40040, 0x10000040, 0x10040000, 0x10001000, 0x10001040, 0, 0x10041040, 0x41000, 0x41000, 4160, 
			4160, 0x40040, 0x10000000, 0x10041000
		};
		int keys[] = des_createKeys(key);
		int m = 0;
		int cbcleft = 0;
		int cbcleft2 = 0;
		int cbcright = 0;
		int cbcright2 = 0;
		int len = message.length();
		int chunk = 0;
		int iterations = keys.length != 32 ? 9 : 3;
		int looping[];
		if (iterations == 3)
			looping = encrypt != 1 ? (new int[] {
				30, -2, -2
			}) : (new int[] {
				0, 32, 2
			});
		else
			looping = encrypt != 0 ? (new int[] {
				94, 62, -2, 32, 64, 2, 30, -2, -2
			}) : (new int[] {
				0, 32, 2, 62, 30, -2, 64, 96, 2
			});
		message = message + "\000\000\000\000\000\000\000\0";
		String result = "";
		String tempresult = "";
		if (mode == 1)
		{
			cbcleft = iv.charAt(m++) << 24 | iv.charAt(m++) << 16 | iv.charAt(m++) << 8 | iv.charAt(m++);
			cbcright = iv.charAt(m++) << 24 | iv.charAt(m++) << 16 | iv.charAt(m++) << 8 | iv.charAt(m++);
			m = 0;
		}
		while (m < len) 
		{
			int left;
			int right;
			if (encrypt == 1)
			{
				left = message.charAt(m++) << 16 | message.charAt(m++);
				right = message.charAt(m++) << 16 | message.charAt(m++);
			} else
			{
				left = message.charAt(m++) << 24 | message.charAt(m++) << 16 | message.charAt(m++) << 8 | message.charAt(m++);
				right = message.charAt(m++) << 24 | message.charAt(m++) << 16 | message.charAt(m++) << 8 | message.charAt(m++);
			}
			if (mode == 1)
				if (encrypt == 1)
				{
					left ^= cbcleft;
					right ^= cbcright;
				} else
				{
					cbcleft2 = cbcleft;
					cbcright2 = cbcright;
					cbcleft = left;
					cbcright = right;
				}
			int temp = (left >>> 4 ^ right) & 0xf0f0f0f;
			right ^= temp;
			left ^= temp << 4;
			temp = (left >>> 16 ^ right) & 0xffff;
			right ^= temp;
			left ^= temp << 16;
			temp = (right >>> 2 ^ left) & 0x33333333;
			left ^= temp;
			right ^= temp << 2;
			temp = (right >>> 8 ^ left) & 0xff00ff;
			left ^= temp;
			right ^= temp << 8;
			temp = (left >>> 1 ^ right) & 0x55555555;
			right ^= temp;
			left ^= temp << 1;
			left = left << 1 | left >>> 31;
			right = right << 1 | right >>> 31;
			for (int j = 0; j < iterations; j += 3)
			{
				int endloop = looping[j + 1];
				int loopinc = looping[j + 2];
				for (int i = looping[j]; i != endloop; i += loopinc)
				{
					int right1 = right ^ keys[i];
					int right2 = (right >>> 4 | right << 28) ^ keys[i + 1];
					temp = left;
					left = right;
					right = temp ^ (spfunction2[right1 >>> 24 & 0x3f] | spfunction4[right1 >>> 16 & 0x3f] | spfunction6[right1 >>> 8 & 0x3f] | spfunction8[right1 & 0x3f] | spfunction1[right2 >>> 24 & 0x3f] | spfunction3[right2 >>> 16 & 0x3f] | spfunction5[right2 >>> 8 & 0x3f] | spfunction7[right2 & 0x3f]);
				}

				temp = left;
				left = right;
				right = temp;
			}

			left = left >>> 1 | left << 31;
			right = right >>> 1 | right << 31;
			temp = (left >>> 1 ^ right) & 0x55555555;
			right ^= temp;
			left ^= temp << 1;
			temp = (right >>> 8 ^ left) & 0xff00ff;
			left ^= temp;
			right ^= temp << 8;
			temp = (right >>> 2 ^ left) & 0x33333333;
			left ^= temp;
			right ^= temp << 2;
			temp = (left >>> 16 ^ right) & 0xffff;
			right ^= temp;
			left ^= temp << 16;
			temp = (left >>> 4 ^ right) & 0xf0f0f0f;
			right ^= temp;
			left ^= temp << 4;
			if (mode == 1)
				if (encrypt == 1)
				{
					cbcleft = left;
					cbcright = right;
				} else
				{
					left ^= cbcleft2;
					right ^= cbcright2;
				}
			if (encrypt == 1)
				tempresult = tempresult + fromCharCode(left >>> 24, left >>> 16 & 0xff, left >>> 8 & 0xff, left & 0xff, right >>> 24, right >>> 16 & 0xff, right >>> 8 & 0xff, right & 0xff);
			else
				tempresult = tempresult + fromCharCode(left >>> 16 & 0xffff, left & 0xffff, right >>> 16 & 0xffff, right & 0xffff);
			if (encrypt == 1)
				chunk += 16;
			else
				chunk += 8;
			if (chunk == 512)
			{
				result = result + tempresult;
				tempresult = "";
				chunk = 0;
			}
		}
		return result + tempresult;
	}

	public static String fromCharCode(int i, int j, int k, int l)
	{
		return fromCharCode(i) + fromCharCode(j) + fromCharCode(k) + fromCharCode(l);
	}

	public static String fromCharCode(int i, int j, int k, int l, int m, int n, int o, int p)
	{
		return fromCharCode(i) + fromCharCode(j) + fromCharCode(k) + fromCharCode(l) + fromCharCode(m) + fromCharCode(n) + fromCharCode(o) + fromCharCode(p);
	}

	public static String fromCharCode(int ival)
	{
		return String.valueOf((char)ival);
	}

	public static int[] des_createKeys(String key)
	{
		int pc2bytes0[] = {
			0, 4, 0x20000000, 0x20000004, 0x10000, 0x10004, 0x20010000, 0x20010004, 512, 516, 
			0x20000200, 0x20000204, 0x10200, 0x10204, 0x20010200, 0x20010204
		};
		int pc2bytes1[] = {
			0, 1, 0x100000, 0x100001, 0x4000000, 0x4000001, 0x4100000, 0x4100001, 256, 257, 
			0x100100, 0x100101, 0x4000100, 0x4000101, 0x4100100, 0x4100101
		};
		int pc2bytes2[] = {
			0, 8, 2048, 2056, 0x1000000, 0x1000008, 0x1000800, 0x1000808, 0, 8, 
			2048, 2056, 0x1000000, 0x1000008, 0x1000800, 0x1000808
		};
		int pc2bytes3[] = {
			0, 0x200000, 0x8000000, 0x8200000, 8192, 0x202000, 0x8002000, 0x8202000, 0x20000, 0x220000, 
			0x8020000, 0x8220000, 0x22000, 0x222000, 0x8022000, 0x8222000
		};
		int pc2bytes4[] = {
			0, 0x40000, 16, 0x40010, 0, 0x40000, 16, 0x40010, 4096, 0x41000, 
			4112, 0x41010, 4096, 0x41000, 4112, 0x41010
		};
		int pc2bytes5[] = {
			0, 1024, 32, 1056, 0, 1024, 32, 1056, 0x2000000, 0x2000400, 
			0x2000020, 0x2000420, 0x2000000, 0x2000400, 0x2000020, 0x2000420
		};
		int pc2bytes6[] = {
			0, 0x10000000, 0x80000, 0x10080000, 2, 0x10000002, 0x80002, 0x10080002, 0, 0x10000000, 
			0x80000, 0x10080000, 2, 0x10000002, 0x80002, 0x10080002
		};
		int pc2bytes7[] = {
			0, 0x10000, 2048, 0x10800, 0x20000000, 0x20010000, 0x20000800, 0x20010800, 0x20000, 0x30000, 
			0x20800, 0x30800, 0x20020000, 0x20030000, 0x20020800, 0x20030800
		};
		int pc2bytes8[] = {
			0, 0x40000, 0, 0x40000, 2, 0x40002, 2, 0x40002, 0x2000000, 0x2040000, 
			0x2000000, 0x2040000, 0x2000002, 0x2040002, 0x2000002, 0x2040002
		};
		int pc2bytes9[] = {
			0, 0x10000000, 8, 0x10000008, 0, 0x10000000, 8, 0x10000008, 1024, 0x10000400, 
			1032, 0x10000408, 1024, 0x10000400, 1032, 0x10000408
		};
		int pc2bytes10[] = {
			0, 32, 0, 32, 0x100000, 0x100020, 0x100000, 0x100020, 8192, 8224, 
			8192, 8224, 0x102000, 0x102020, 0x102000, 0x102020
		};
		int pc2bytes11[] = {
			0, 0x1000000, 512, 0x1000200, 0x200000, 0x1200000, 0x200200, 0x1200200, 0x4000000, 0x5000000, 
			0x4000200, 0x5000200, 0x4200000, 0x5200000, 0x4200200, 0x5200200
		};
		int pc2bytes12[] = {
			0, 4096, 0x8000000, 0x8001000, 0x80000, 0x81000, 0x8080000, 0x8081000, 16, 4112, 
			0x8000010, 0x8001010, 0x80010, 0x81010, 0x8080010, 0x8081010
		};
		int pc2bytes13[] = {
			0, 4, 256, 260, 0, 4, 256, 260, 1, 5, 
			257, 261, 1, 5, 257, 261
		};
		int iterations = key.length() < 24 ? 1 : 3;
		int keys[] = new int[32 * iterations];
		int shifts[] = {
			0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 
			1, 1, 1, 1, 1, 0
		};
		int m = 0;
		int n = 0;
		int left = 0;
		int right = 0;
		for (int j = 0; j < iterations; j++)
		{
			left = key.charAt(m++) << 24 | key.charAt(m++) << 16 | key.charAt(m++) << 8 | key.charAt(m++);
			right = key.charAt(m++) << 24 | key.charAt(m++) << 16 | key.charAt(m++) << 8 | key.charAt(m++);
			int temp = (left >>> 4 ^ right) & 0xf0f0f0f;
			right ^= temp;
			left ^= temp << 4;
			temp = (right >>> -16 ^ left) & 0xffff;
			left ^= temp;
			right ^= temp << -16;
			temp = (left >>> 2 ^ right) & 0x33333333;
			right ^= temp;
			left ^= temp << 2;
			temp = (right >>> -16 ^ left) & 0xffff;
			left ^= temp;
			right ^= temp << -16;
			temp = (left >>> 1 ^ right) & 0x55555555;
			right ^= temp;
			left ^= temp << 1;
			temp = (right >>> 8 ^ left) & 0xff00ff;
			left ^= temp;
			right ^= temp << 8;
			temp = (left >>> 1 ^ right) & 0x55555555;
			right ^= temp;
			left ^= temp << 1;
			temp = left << 8 | right >>> 20 & 0xf0;
			left = right << 24 | right << 8 & 0xff0000 | right >>> 8 & 0xff00 | right >>> 24 & 0xf0;
			right = temp;
			for (int i = 0; i < shifts.length; i++)
			{
				if (shifts[i] != 0)
				{
					left = left << 2 | left >>> 26;
					right = right << 2 | right >>> 26;
				} else
				{
					left = left << 1 | left >>> 27;
					right = right << 1 | right >>> 27;
				}
				left &= 0xfffffff1;
				right &= 0xfffffff1;
				int lefttemp = pc2bytes0[left >>> 28] | pc2bytes1[left >>> 24 & 0xf] | pc2bytes2[left >>> 20 & 0xf] | pc2bytes3[left >>> 16 & 0xf] | pc2bytes4[left >>> 12 & 0xf] | pc2bytes5[left >>> 8 & 0xf] | pc2bytes6[left >>> 4 & 0xf];
				int righttemp = pc2bytes7[right >>> 28] | pc2bytes8[right >>> 24 & 0xf] | pc2bytes9[right >>> 20 & 0xf] | pc2bytes10[right >>> 16 & 0xf] | pc2bytes11[right >>> 12 & 0xf] | pc2bytes12[right >>> 8 & 0xf] | pc2bytes13[right >>> 4 & 0xf];
				temp = (righttemp >>> 16 ^ lefttemp) & 0xffff;
				keys[n++] = lefttemp ^ temp;
				keys[n++] = righttemp ^ temp << 16;
			}

		}

		return keys;
	}

	public static String stringToHex(String s)
	{
		String r = "";
		String hexes[] = {
			"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
			"a", "b", "c", "d", "e", "f"
		};
		for (int i = 0; i < s.length(); i++)
			r = r + hexes[s.charAt(i) >> 4] + hexes[s.charAt(i) & 0xf];

		return r;
	}

	public static String HexTostring(String s)
	{
		String r = "";
		s = s.trim();
		for (int i = 0; i < s.length(); i += 2)
		{
			int sxx = Integer.parseInt(s.substring(i, i + 2), 16);
			r = r + fromCharCode(sxx);
		}

		return r;
	}

	public static String encMe(String key, String s)
	{
		return stringToHex(des(key, s, 1, 0, ""));
	}

	public static String uncMe(String key, String s)
	{
		return des(key, HexTostring(s), 0, 0, "");
	}
	
	
	public static String uncMe_nokey(String s){
		return uncMe("www.si-tech.com.cn",s);
	}
	%>