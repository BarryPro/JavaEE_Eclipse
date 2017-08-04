<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page session = "true" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%> 
<%!
	    static final String ACTIVEFLAG     = "OK";
        static final int S11 = 7;
        static final int S12 = 12;
        static final int S13 = 17;
        static final int S14 = 22;

        static final int S21 = 5;
        static final int S22 = 9;
        static final int S23 = 14;
        static final int S24 = 20;

        static final int S31 = 4;
        static final int S32 = 11;
        static final int S33 = 16;
        static final int S34 = 23;

        static final int S41 = 6;
        static final int S42 = 10;
        static final int S43 = 15;
        static final int S44 = 21;


        static final byte[] PADDING = { -128, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

        private long[] state = new long[4];  // state (ABCD)
        private long[] count = new long[2];  // number of bits, modulo 2^64 (lsb first)
        private byte[] buffer = new byte[64]; // input buffer
        

		public void md5Init(){
			count[0] = 0L;
	        count[1] = 0L;
	        // Load magic initialization constants.
	
	        state[0] = 0x67452301L;
	        state[1] = 0xefcdab89L;
	        state[2] = 0x98badcfeL;
	        state[3] = 0x10325476L;
		}

		public String digestHexStr;
        
        private byte[] digest = new byte[16];
        
        public String getMD5ofStr(String inbuf) {
                md5Init();
                md5Update(inbuf.getBytes(), inbuf.length());
                md5Final();
                digestHexStr = "";
                for (int i = 0; i < 16; i++) {
                        digestHexStr += byteHEX(digest[i]);
                }
                return digestHexStr;

        }

        private long F(long x, long y, long z) {
                return (x & y) | ((~x) & z);

        }
        private long G(long x, long y, long z) {
                return (x & z) | (y & (~z));

        }
        private long H(long x, long y, long z) {
                return x ^ y ^ z;
        }

        private long I(long x, long y, long z) {
                return y ^ (x | (~z));
        }
        
        private long FF(long a, long b, long c, long d, long x, long s,
                long ac) {
                a += F (b, c, d) + x + ac;
                a = ((int) a << s) | ((int) a >>> (32 - s));
                a += b;
                return a;
        }

        private long GG(long a, long b, long c, long d, long x, long s,
                long ac) {
                a += G (b, c, d) + x + ac;
                a = ((int) a << s) | ((int) a >>> (32 - s));
                a += b;
                return a;
        }
        private long HH(long a, long b, long c, long d, long x, long s,
                long ac) {
                a += H (b, c, d) + x + ac;
                a = ((int) a << s) | ((int) a >>> (32 - s));
                a += b;
                return a;
        }
        private long II(long a, long b, long c, long d, long x, long s,
                long ac) {
                a += I (b, c, d) + x + ac;
                a = ((int) a << s) | ((int) a >>> (32 - s));
                a += b;
                return a;
        }
        private void md5Update(byte[] inbuf, int inputLen) {

                int i, index, partLen;
                byte[] block = new byte[64];
                index = (int)(count[0] >>> 3) & 0x3F;
                 /* Update number of bits */


                if ((count[0] += (inputLen << 3)) < (inputLen << 3))
                        count[1]++;
                count[1] += (inputLen >>> 29);

                partLen = 64 - index;

                // Transform as many times as possible.
                if (inputLen >= partLen) {
                        md5Memcpy(buffer, inbuf, index, 0, partLen);
                        md5Transform(buffer);

                        for (i = partLen; i + 63 < inputLen; i += 64) {

                                md5Memcpy(block, inbuf, 0, i, 64);
                                md5Transform (block);
                        }
                        index = 0;

                } else

                        i = 0;

                /* Buffer remaining input */
                md5Memcpy(buffer, inbuf, index, i, inputLen - i);

        }
        
        private void md5Final () {
                byte[] bits = new byte[8];
                int index, padLen;

                /* Save number of bits */
                Encode (bits, count, 8);

                // Pad out to 56 mod 64.
                index = (int)(count[0] >>> 3) & 0x3f;
                padLen = (index < 56) ? (56 - index) : (120 - index);
                md5Update (PADDING, padLen);

                /* Append length (before padding) */
                md5Update(bits, 8);

                /* Store state in digest */
                Encode (digest, state, 16);

        }
         
        private void md5Memcpy (byte[] output, byte[] input,
                int outpos, int inpos, int len)
        {
                int i;

                for (i = 0; i < len; i++)
                        output[outpos + i] = input[inpos + i];
        }
        
        private void md5Transform (byte block[]) {
                long a = state[0], b = state[1], c = state[2], d = state[3];
                long[] x = new long[16];

                Decode (x, block, 64);

                /* Round 1 */
                a = FF (a, b, c, d, x[0], S11, 0xd76aa478L); /* 1 */
                d = FF (d, a, b, c, x[1], S12, 0xe8c7b756L); /* 2 */
                c = FF (c, d, a, b, x[2], S13, 0x242070dbL); /* 3 */
                b = FF (b, c, d, a, x[3], S14, 0xc1bdceeeL); /* 4 */
                a = FF (a, b, c, d, x[4], S11, 0xf57c0fafL); /* 5 */
                d = FF (d, a, b, c, x[5], S12, 0x4787c62aL); /* 6 */
                c = FF (c, d, a, b, x[6], S13, 0xa8304613L); /* 7 */
                b = FF (b, c, d, a, x[7], S14, 0xfd469501L); /* 8 */
                a = FF (a, b, c, d, x[8], S11, 0x698098d8L); /* 9 */
                d = FF (d, a, b, c, x[9], S12, 0x8b44f7afL); /* 10 */
                c = FF (c, d, a, b, x[10], S13, 0xffff5bb1L); /* 11 */
                b = FF (b, c, d, a, x[11], S14, 0x895cd7beL); /* 12 */
                a = FF (a, b, c, d, x[12], S11, 0x6b901122L); /* 13 */
                d = FF (d, a, b, c, x[13], S12, 0xfd987193L); /* 14 */
                c = FF (c, d, a, b, x[14], S13, 0xa679438eL); /* 15 */
                b = FF (b, c, d, a, x[15], S14, 0x49b40821L); /* 16 */

                /* Round 2 */
                a = GG (a, b, c, d, x[1], S21, 0xf61e2562L); /* 17 */
                d = GG (d, a, b, c, x[6], S22, 0xc040b340L); /* 18 */
                c = GG (c, d, a, b, x[11], S23, 0x265e5a51L); /* 19 */
                b = GG (b, c, d, a, x[0], S24, 0xe9b6c7aaL); /* 20 */
                a = GG (a, b, c, d, x[5], S21, 0xd62f105dL); /* 21 */
                d = GG (d, a, b, c, x[10], S22, 0x2441453L); /* 22 */
                c = GG (c, d, a, b, x[15], S23, 0xd8a1e681L); /* 23 */
                b = GG (b, c, d, a, x[4], S24, 0xe7d3fbc8L); /* 24 */
                a = GG (a, b, c, d, x[9], S21, 0x21e1cde6L); /* 25 */
                d = GG (d, a, b, c, x[14], S22, 0xc33707d6L); /* 26 */
                c = GG (c, d, a, b, x[3], S23, 0xf4d50d87L); /* 27 */
                b = GG (b, c, d, a, x[8], S24, 0x455a14edL); /* 28 */
                a = GG (a, b, c, d, x[13], S21, 0xa9e3e905L); /* 29 */
                d = GG (d, a, b, c, x[2], S22, 0xfcefa3f8L); /* 30 */
                c = GG (c, d, a, b, x[7], S23, 0x676f02d9L); /* 31 */
                b = GG (b, c, d, a, x[12], S24, 0x8d2a4c8aL); /* 32 */

                /* Round 3 */
                a = HH (a, b, c, d, x[5], S31, 0xfffa3942L); /* 33 */
                d = HH (d, a, b, c, x[8], S32, 0x8771f681L); /* 34 */
                c = HH (c, d, a, b, x[11], S33, 0x6d9d6122L); /* 35 */
                b = HH (b, c, d, a, x[14], S34, 0xfde5380cL); /* 36 */
                a = HH (a, b, c, d, x[1], S31, 0xa4beea44L); /* 37 */
                d = HH (d, a, b, c, x[4], S32, 0x4bdecfa9L); /* 38 */
                c = HH (c, d, a, b, x[7], S33, 0xf6bb4b60L); /* 39 */
                b = HH (b, c, d, a, x[10], S34, 0xbebfbc70L); /* 40 */
                a = HH (a, b, c, d, x[13], S31, 0x289b7ec6L); /* 41 */
                d = HH (d, a, b, c, x[0], S32, 0xeaa127faL); /* 42 */
                c = HH (c, d, a, b, x[3], S33, 0xd4ef3085L); /* 43 */
                b = HH (b, c, d, a, x[6], S34, 0x4881d05L); /* 44 */
                a = HH (a, b, c, d, x[9], S31, 0xd9d4d039L); /* 45 */
                d = HH (d, a, b, c, x[12], S32, 0xe6db99e5L); /* 46 */
                c = HH (c, d, a, b, x[15], S33, 0x1fa27cf8L); /* 47 */
                b = HH (b, c, d, a, x[2], S34, 0xc4ac5665L); /* 48 */

                /* Round 4 */
                a = II (a, b, c, d, x[0], S41, 0xf4292244L); /* 49 */
                d = II (d, a, b, c, x[7], S42, 0x432aff97L); /* 50 */
                c = II (c, d, a, b, x[14], S43, 0xab9423a7L); /* 51 */
                b = II (b, c, d, a, x[5], S44, 0xfc93a039L); /* 52 */
                a = II (a, b, c, d, x[12], S41, 0x655b59c3L); /* 53 */
                d = II (d, a, b, c, x[3], S42, 0x8f0ccc92L); /* 54 */
                c = II (c, d, a, b, x[10], S43, 0xffeff47dL); /* 55 */
                b = II (b, c, d, a, x[1], S44, 0x85845dd1L); /* 56 */
                a = II (a, b, c, d, x[8], S41, 0x6fa87e4fL); /* 57 */
                d = II (d, a, b, c, x[15], S42, 0xfe2ce6e0L); /* 58 */
                c = II (c, d, a, b, x[6], S43, 0xa3014314L); /* 59 */
                b = II (b, c, d, a, x[13], S44, 0x4e0811a1L); /* 60 */
                a = II (a, b, c, d, x[4], S41, 0xf7537e82L); /* 61 */
                d = II (d, a, b, c, x[11], S42, 0xbd3af235L); /* 62 */
                c = II (c, d, a, b, x[2], S43, 0x2ad7d2bbL); /* 63 */
                b = II (b, c, d, a, x[9], S44, 0xeb86d391L); /* 64 */

                state[0] += a;
                state[1] += b;
                state[2] += c;
                state[3] += d;

        }
        
        private void Encode (byte[] output, long[] input, int len) {
                int i, j;

                for (i = 0, j = 0; j < len; i++, j += 4) {
                        output[j] = (byte)(input[i] & 0xffL);
                        output[j + 1] = (byte)((input[i] >>> 8) & 0xffL);
                        output[j + 2] = (byte)((input[i] >>> 16) & 0xffL);
                        output[j + 3] = (byte)((input[i] >>> 24) & 0xffL);
                }
        }

        private void Decode (long[] output, byte[] input, int len) {
                int i, j;


                for (i = 0, j = 0; j < len; i++, j += 4)
                        output[i] = b2iu(input[j]) |
                                (b2iu(input[j + 1]) << 8) |
                                (b2iu(input[j + 2]) << 16) |
                                (b2iu(input[j + 3]) << 24);

                return;
        }
       
        public static long b2iu(byte b) {
                return b < 0 ? b & 0x7F + 128 : b;
        }
        
        public static String byteHEX(byte ib) {
                char[] Digit = { '0','1','2','3','4','5','6','7','8','9',
                'A','B','C','D','E','F' };
                char [] ob = new char[2];
                ob[0] = Digit[(ib >>> 4) & 0X0F];
                ob[1] = Digit[ib & 0X0F];
                String s = new String(ob);
                return s;
        }

	public final static String getNowTime() {
		java.text.SimpleDateFormat formatter1
			= new  java.text.SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		return  formatter1.format(new java.util.Date());
	}

	public final static Date stringToDateTime(String cDate) throws ParseException{
        try{
        	SimpleDateFormat formatter1 = new  SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
        	return  formatter1.parse(cDate);
        }
		catch(ParseException e){
			try{
        		SimpleDateFormat formatter1 = new  SimpleDateFormat ("yyyyMMdd HH:mm:ss");
        		return  formatter1.parse(cDate);
			}
            catch(ParseException ee){
            	SimpleDateFormat formatter1 = new  SimpleDateFormat ("yyyy-MM-dd");
            	return  formatter1.parse(cDate);
            }
		}
	}

    public static Date computeDate(Date date, char type, int timeInterval){
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        int Time_year = cal.get(Calendar.YEAR);
        int Time_month = cal.get(Calendar.MONTH);
        int Time_day = cal.get(Calendar.DAY_OF_MONTH);
        int   Time_hour = cal.get(Calendar.HOUR_OF_DAY);
        int  Time_minute =cal.get(Calendar.MINUTE);
        int Time_second = cal.get(Calendar.SECOND);

        switch(type){
            case 'y':
                {
                    Time_year = Time_year + timeInterval;
                    cal.set(Calendar.YEAR,Time_year);
                }
                break;

            case 'm':
                {
                    Time_month = Time_month + timeInterval;
                    cal.set(Calendar.MONTH,Time_month);
                }
                break;

            case 'd':
                {
                    Time_day = Time_day + timeInterval;
                    cal.set(Calendar.DAY_OF_MONTH,Time_day);
                }
                break;

            case 'h':
                {
                    Time_hour = Time_hour + timeInterval;
                    cal.set(Calendar.HOUR_OF_DAY,Time_hour);
                }
                break;

            case 'f':
                {
                    Time_minute = Time_minute + timeInterval;
                    cal.set(Calendar.MINUTE,Time_minute);
                }
                break;

            case 's':
                {
                    Time_second = Time_second + timeInterval;
                    cal.set(Calendar.SECOND,Time_second);
                }
                break;
            default:
                break;
        }
		date =    cal.getTime();
		return  date;
    }

	String detect(String detectUrl) {
        boolean state = false;
        String result = "";
        try {
            URL url = new URL(detectUrl);
            URLConnection con = url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(false);
            con.setDoInput(true);

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(con.getInputStream())
            );
            StringBuffer buffer = new StringBuffer();
            String line = reader.readLine();
            while (line != null) {
                buffer.append(line);
                line = reader.readLine();
            }
            result = buffer.toString();
			if(result.equals(ACTIVEFLAG))
				state = true;
        } catch (IOException e) {
        } catch (Exception e) {
        }
		return result;
    }
%>

<%
	System.out.println("-ntn-----------authGRPCheck.jsp------------yuanqs---------");
 
	String user = request.getParameter("user");
	if(user==null){
		out.println("数据无效！");
		return;
	}
	String check1 = (String)application.getAttribute(user);
	String activePhone = request.getParameter("activePhone");
	String system_code = request.getParameter("system_code");
	String cDate = request.getParameter("cDate");
	String url = request.getRemoteHost();
	String targeturl = request.getParameter("targeturl");
	
	String random = request.getParameter("random");
	String check = request.getParameter("check");
	String workNo = (String)request.getParameter("user");
	String nopass = (String)request.getParameter("password");
	String selfIp = (String)request.getParameter("selfIp");
	String regionCode = (String)request.getParameter("regionCode");
	String opName = request.getParameter("opName");
	String opCode = request.getParameter("opCode");
	//String check2 = getMD5ofStr(user+cDate+url+targeturl+random+system_code);
	String check2 = getMD5ofStr(user + cDate + targeturl + random); 
	System.out.println("=====ntn======yuanqs=====check1==============" + check1);
	System.out.println("======ntn=====yuanqs=====activePhone==============" + activePhone);
	System.out.println("=======ntn====yuanqs=====system_code==============" + system_code);
	System.out.println("=======ntn====yuanqs=====cDate==============" + cDate);
	System.out.println("=======ntn====yuanqs=====url==============" + url);
	System.out.println("=======ntn====yuanqs=====targeturl==============" + targeturl);
	System.out.println("======ntn=====yuanqs=====random==============" + random);
	System.out.println("=======ntn====yuanqs=====check==============" + check);
	System.out.println("=====ntn======yuanqs=====workNo==============" + workNo);
	System.out.println("=======ntn====yuanqs=====nopass==============" + nopass);
	System.out.println("=====ntn======yuanqs=====selfIp==============" + selfIp);
	System.out.println("=====ntn======yuanqs=====regionCode==============" + regionCode);
	System.out.println("=====ntn======yuanqs=====opName==============" + opName);
	System.out.println("======ntn=====yuanqs=====opCode==============" + opCode);
	System.out.println("=====ntn======yuanqs=====check2==============" + check2);
	if (!"/".equals(targeturl.substring(0, 1))) {
		targeturl = "../" + targeturl;
	}
	
	if(!check.equals(check2)){
		out.println("数据被篡改！");
		return;
	}
	
	//if(!check.equals(check1)){
		//out.println("数据非法！");
		//return;
	//}
	
	Date beginDate = stringToDateTime(cDate);
	Date validDate = computeDate(beginDate,'f',1);
	if(beginDate.after(new Date())){
		//out.println("时间戳已失效！请重试一次！");
		//return;
	}
	application.removeAttribute(user);

/* 认证通过，转到相应的处理*/
	ContactInfo contactInfo = new ContactInfo();
    contactInfo.setPhoneno(activePhone);
    contactInfo.setPasswdVal("",0);
	contactInfo.setPasswd_status(""); 
	System.out.println("-hjw----activePhone--"+activePhone);
    Map map = new HashMap();
    map.put(activePhone, contactInfo);
    
	session.setAttribute("contactInfoMap",map);
	session.setAttribute("cssPath","default");
	String exworkNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	System.out.println("====wanghfa==== ntn exworkNo = " + exworkNo);
	if(!exworkNo.equals(workNo)){
	String sessionIdStr = session.getId();
%>

	<wtc:service name="sLoginCheck" outnum="46"  retmsg="msg" retcode="retCode" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=selfIp%>"/>
		<wtc:param value="<%=selfIp%>" />
		<wtc:param value="15" />
		<wtc:param value="" />
		<wtc:param value="<%=sessionIdStr%>" />
	</wtc:service>
	<wtc:array id="str1" scope="end" start="0" length="24"/>
	<wtc:array id="str2" scope="end" start="24" length="4"/>
	<wtc:array id="str3" scope="end" start="28" length="8"/>
	<wtc:array id="str4" scope="end" start="36" length="1"/>
	<wtc:array id="str5" scope="end" start="37" length="1"/>
	<wtc:array id="str6" scope="end" start="38" length="6"/>
	<wtc:array id="str7" scope="end" start="44" length="1"/>
	<wtc:array id="str8" scope="end" start="45" length="1"/>
<%
System.out.println("==ntn==wanghfa==== sLoginCheck retCode = " + retCode + ", msg = " + msg);
if(retCode.equals("000000")||retCode.equals("-1"))
{
	ArrayList arr=new ArrayList();
			arr.add(str1);
			arr.add(str2);
			arr.add(str3);
			arr.add(str4);
			arr.add(str5);
			arr.add(str6);
			arr.add(str7);
			arr.add(str8);
	String[][] lastInfo = (String[][])arr.get(4);		
  	String lastPass = lastInfo[0][0].trim();
	String rtn_code = str1[0][0].trim();
	String rtn_message = str1[0][1].trim();
	String department = str1[0][16];
	
	String orgCode = str1[0][16].trim();
	String workName = str1[0][3].trim();
	
	String groupId = str1[0][21].trim();
	String orgId  = str1[0][23].trim();
	String powerCode = str1[0][4].trim();
	String powerRight = str1[0][5].trim();
	String rptRight = str1[0][6].trim();
	String deptCode = str3[0][3];
	//String passTime = str8[0][0].trim();
	String accountType = str7[0][0];
	//String kf_login_no = str8[0][0]; 
	//String modGraFlag = str9[0][0];
	String loginFlag = str1[0][15].trim();  //服务中名字为 smaintain_flag  :系统维护标志
	
	String sql = "select group_id,group_name from dchngroupmsg where boss_org_code = '" + orgCode.substring(0,7) + "'";


	%>	<wtc:service name="sPubSelect" outnum="2">
			<wtc:sql><%=sql%></wtc:sql>
			</wtc:service>
			<wtc:array id="result" scope="end" />
	<%
	String groupName ="";
	if( result.length > 0 ){
	groupId = result[0][0];
  groupName = result[0][1];
  }
	session.setAttribute("accountType",accountType);
     //if( accountType.equals("2") ){
			//	session.setAttribute("kf_login_no",kf_login_no.trim());
			//}	
 	session.setAttribute("allArr",arr);
	session.setAttribute("password",lastPass);
	session.setAttribute("workNo",workNo);
	session.setAttribute("workName",workName);
	session.setAttribute("groupId",groupId);
	session.setAttribute("groupName",groupName);
	session.setAttribute("powerCode",powerCode);
	session.setAttribute("orgId",orgId);
	session.setAttribute("powerCode",powerCode);
	session.setAttribute("powerRight",powerRight);
	session.setAttribute("rptRight",rptRight);
	session.setAttribute("favInfo",str4);
	session.setAttribute("deptCode",deptCode);
	session.setAttribute("orgCode",orgCode);
	session.setAttribute("loginFlag",loginFlag);
	session.setAttribute("created_no", workNo);
	session.setAttribute("created_name", workName);
	session.setAttribute("maintain_flag", "2");
	session.setAttribute("serGroupName", groupName);
	session.setAttribute("serGroupId", groupId);
	session.setAttribute("regionCodeName",groupName);
	session.setAttribute("rptGroupName", groupName);
	session.setAttribute("rptGroupId", groupId);
	session.setAttribute("opCode","10020");
	session.setAttribute("phoneHeadList",null);

	if( orgCode != null && orgCode.length()>2 ){
		regionCode = orgCode.substring(0,2);
		session.setAttribute("regCode",regionCode);
		session.setAttribute("regionCode",regionCode);
	}

	//获取当前年月日
	Date currentDate = new Date(System.currentTimeMillis());
	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
	String currentYear = formatter.format(currentDate);
	session.setAttribute("currentYear",currentYear);
	session.setAttribute("ipAddr",str3[0][2]);
	session.setAttribute("verifyFlag","false");
	


	/*
	 * add by liuyya 2010-10-09
	 * 解决电话经理系统跳转到boss的样式问题
	 */
  String versonType = request.getParameter("versonType"); // 页面框架版本:: normal:普通版;simple:高速版.
  session.setAttribute("versonType",versonType);
  

    User user1 = new User();
    user1.setLoginNo(workNo);
    user1.setLoginName(str1[0][3].trim());
    user1.setIp(selfIp);
    user1.setLoginTime(DateUtils.getNowTime());
    user1.setUnitName(str3[0][5].trim()+"-"+str3[0][6].trim()+"-"+str3[0][7].trim());
	Counter.login(selfIp,user1);

	//获取组织机构代码和名称，其实可以放入sLoginCheck中做查询的
	int recordNum = 0;
	String sqlStr = "";
    sqlStr = "SELECT a.group_id,b.group_name FROM dLoginMsg a,dChnGroupMsg b WHERE a.login_no=:vloginno AND a.group_id=b.group_id";
    String var1 = "vloginno="+workNo;
%>
        <wtc:service name="TlsPubSelCrm"  outnum="2" >
		    <wtc:param value="<%=sqlStr%>"/>
		    <wtc:param value="<%=var1%>"/>
        </wtc:service>
        <wtc:array id="result" scope="end" />
<%
	recordNum = result.length;
	if(recordNum > 0){
		session.setAttribute("workGroupId", result[0][0].trim());
		session.setAttribute("orgName", result[0][1].trim());
	}else{
		sqlStr = "SELECT a.group_id,b.group_name FROM dLoginMsg a,dbresadm.dChnGroupMsg b WHERE a.login_no=:vloginno AND a.group_id=b.group_id";
		var1 = "vloginno="+workNo;
%>
        <wtc:service name="TlsPubSelCrm"  outnum="2" >
		    <wtc:param value="<%=sqlStr%>"/>
		    <wtc:param value="<%=var1%>"/>
        </wtc:service>
        <wtc:array id="result" scope="end" />
<%
		int recordNum_temp = result.length;
		if (recordNum_temp > 0) {
			session.setAttribute("workGroupId", result[0][0].trim());
			session.setAttribute("orgName", result[0][1].trim());
		}
	}
	//if( accountType.equals("2")){
    //session.setAttribute("userPhoneNo","");	
  //}
  
}else{
	out.println("系统错误:"+retCode);
	return;
 }
 }
	String allowEnd = "0";
	String getAllowEndSql = "SELECT TO_CHAR(allow_end, 'HH24miss')"
				+ " FROM dloginmsg WHERE TO_CHAR (SYSDATE, 'HH24miss') - TO_CHAR (allow_begin, 'HH24miss') > 0"
				+ " AND login_no = :login_no";
	String[] inParams = new String[2];
	inParams[0] = getAllowEndSql;
	inParams[1] = "login_no="+workNo;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
		 retcode="retCode1" retmsg="retMsg1" outnum="1"> 
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service> 
	<wtc:array id="allowEndRes" scope="end" />
<%
	if(retCode1.equals("000000")){
		if(allowEndRes.length > 0){
			allowEnd = allowEndRes[0][0];
		}else{
%>
		<script language="javascript">
		rdShowMessageDialog("当前时间不允许该工号登录");
		this.close();
		</script>
<%
		}
	}
	session.setAttribute("allowend",allowEnd);
	
	try {
		String sqlStr ="SELECT no FROM dbresadm.snotype order by no";
		%>
			<wtc:pubselect name="sPubSelect" outnum="1">
				<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />
		<%
		if( result.length > 0 ) {
			String []phoneHeadList = new String[result.length];
			
			for(int i=0 ; result != null && i< result.length; i++)
			{
			phoneHeadList[i] = result[i][0];
			}
			session.setAttribute("phoneHeadList",phoneHeadList);
		} else {
			session.setAttribute("phoneHeadList",null);
		}
	} catch(Exception e) {
		session.setAttribute("phoneHeadList",null);
	}
%>
<HTML>
<HEAD>
<TITLE>Login......</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
</HEAD>
<body>
<FORM METHOD=POST NAME=main  ACTION="<%= targeturl %>">
      <INPUT TYPE="hidden" NAME="user" value="<%= user %>" >
      <INPUT TYPE="hidden" NAME="date" value="<%= cDate %>" >
      <INPUT TYPE="hidden" NAME="url" value="<%= url %>"  >
      <INPUT TYPE="hidden" NAME="random" value="<%= random %>"  >
      <INPUT TYPE="hidden" NAME="check" value="<%= check %>"  >
      <INPUT TYPE="hidden" NAME="activePhone" value="<%= activePhone %>"  >
      <INPUT TYPE="hidden" NAME="opName" value="<%= opName %>"  >
      <INPUT TYPE="hidden" NAME="opCode" value="<%= opCode %>"  >
</FORM>
</body>
<script>
        document.main.submit();
        function submit(){
                document.login.submit();
        }
</script>

