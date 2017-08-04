<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%@ page import="java.util.*" %>

<%!
//以下方法为实体营业厅管理使用的加密方法
private String encrypt(String host){
	if (host==null || "".equals(host)){
		return ""; 
	}
	try{
		Cipher encryptCipher = null;
		String strDefaultKey = "www.si-tech.com.cn";
		//Security.addProvider(new com.sun.crypto.provider.SunJCE());
		Key key = getKey(strDefaultKey.getBytes());

		encryptCipher = Cipher.getInstance("DES");
		encryptCipher.init(Cipher.ENCRYPT_MODE, key);

		return byteArr2HexStr(encryptCipher.doFinal(host.getBytes()));
	}
	catch(Exception e){
		e.printStackTrace();
		return "";
	}
}
//////以下方法用户加密渠道信息
//Add by Mumu Lee at 20060627 begin
private String getHostE(String host){
	if (host==null || "".equals(host)){
		return ""; 
	}
	try{
		Cipher encryptCipher = null;
		String strDefaultKey = "MumuLee";
		//Security.addProvider(new com.sun.crypto.provider.SunJCE());
		Key key = getKey(strDefaultKey.getBytes());

		encryptCipher = Cipher.getInstance("DES");
		encryptCipher.init(Cipher.ENCRYPT_MODE, key);

		return byteArr2HexStr(encryptCipher.doFinal(host.getBytes()));
	}
	catch(Exception e){
		e.printStackTrace();
		return "";
	}
}

private static String byteArr2HexStr(byte[] arrB) throws Exception {
	int iLen = arrB.length;
	//每个byte用两个字符才能表示，所以字符串的长度是数组长度的两倍
	StringBuffer sb = new StringBuffer(iLen * 2);
	for (int i = 0; i < iLen; i++) {
		int intTmp = arrB[i];
		//把负数转换为正数
		while (intTmp < 0) {
			intTmp = intTmp + 256;
		}
		//小于0F的数需要在前面补0
		if (intTmp < 16) {
			sb.append("0");
		}
		sb.append(Integer.toString(intTmp, 16));
	}
	return sb.toString();
}

private Key getKey(byte[] arrBTmp) throws Exception {
	//创建一个空的8位字节数组（默认值为0）
	byte[] arrB = new byte[8];
	//将原始字节数组转换为8位
	for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
		arrB[i] = arrBTmp[i];
	}
	//生成密钥
	Key key = new javax.crypto.spec.SecretKeySpec(arrB, "DES");
	return key;
}

private static String[] tokenizeToStringArray(String str, String delimiters) {
		return tokenizeToStringArray(str, delimiters, true, true);
}

private static String[] tokenizeToStringArray(
		String str, String delimiters, boolean trimTokens, boolean ignoreEmptyTokens) {

	java.util.StringTokenizer st = new java.util.StringTokenizer(str, delimiters);
	List tokens = new ArrayList();
	while (st.hasMoreTokens()) {
		String token = st.nextToken();
		if (trimTokens) {
			token = token.trim();
		}
		if (!ignoreEmptyTokens || token.length() > 0) {
			tokens.add(token);
		}
	}
	return toStringArray(tokens);
}

private static String[] toStringArray(Collection collection) {
		if (collection == null) {
			return null;
		}
		return (String[]) collection.toArray(new String[collection.size()]);
}

private static String replace(String inString, String oldPattern, String newPattern) {
		if (inString == null) {
			return null;
		}
		if (oldPattern == null || newPattern == null) {
			return inString;
		}

		StringBuffer sbuf = new StringBuffer();
		// output StringBuffer we'll build up
		int pos = 0; // our position in the old string
		int index = inString.indexOf(oldPattern);
		// the index of an occurrence we've found, or -1
		int patLen = oldPattern.length();
		while (index >= 0) {
			sbuf.append(inString.substring(pos, index));
			sbuf.append(newPattern);
			pos = index + patLen;
			index = inString.indexOf(oldPattern, pos);
		}
		sbuf.append(inString.substring(pos));

		// remember to append any characters to the right of a match
		return sbuf.toString();
	}
//Add by Mumu Lee at 20060627 end

String getLink(String openFlag,String link,String funcode,HttpSession session,HttpServletRequest request,String funcname)
{
		/**
		System.out.println("         ");
		System.out.println("openFlag="+openFlag+"$$link="+link+"$$funcode="+funcode+"$$funcname="+funcname);
		System.out.println("                ");
		**/
		String workNo = (String)session.getAttribute("workNo");
		String nopass = (String) session.getAttribute("password");/*操作员密码*/
		String workName = (String)session.getAttribute("workName");
		String orgName = (String)session.getAttribute("orgName");
		String deptCode = (String)session.getAttribute("deptCode");
		String powerCode = (String)session.getAttribute("powerCode");
		String powerCodekf = (String)session.getAttribute("powerCodekf");
		String powerRight = (String)session.getAttribute("powerRight");
		String orgCode = (String)session.getAttribute("orgCode");
		String workGroupId = (String)session.getAttribute("workGroupId");
		String groupId = (String)session.getAttribute("groupId");

		String ip = request.getServerName().trim();
    //System.out.println("@@@@@@@@@@@@@@@@@@@link@@@@"+link);

		String query_str = "";
		try{
			if ( !workNo.trim().equals("") )
			        query_str +="?login_no="+workNo;
			if ( !workName.trim().equals("") )
			        query_str += "&login_name="+workName;
			if ( !orgCode.trim().equals("") )
			        query_str += "&org_code="+orgCode;
			if ( !deptCode.trim().equals("") )
			        query_str += "&dept_code="+deptCode;
			if ( !workGroupId.trim().equals("") )
			        query_str += "&work_group_id="+workGroupId;
			if ( !orgName.trim().equals("") )
			        query_str += "&org_name="+orgName;
			if ( !funcode.trim().equals("") )
           query_str += "&funcode="+funcode;
		}catch(Exception ne){
		}

		String selfIPPort="http://"+request.getServerName()+":"+request.getServerPort();
		String sLink="";
		sLink=link;

		if ((sLink.equals("#"))||(sLink.length()<4)){
			return sLink;
		}else if( sLink.indexOf("chncard") != -1 ){
			//ip = "http://"+"10.110.0.100"+":42000/";
			//ip = "http://"+"10.110.0.206"+":40007/";
			ip = "http://"+"10.110.13.52"+":10007/";
			sLink = sLink.substring(sLink.indexOf("chncard")+8,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink = ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink = ip+sLink+query_str;
			}
			sLink=ip+"ResMngSystem/page/resmng/common/chncardauth.jsp?"+sLink;
		}else if( sLink.indexOf("chnterm") != -1 ){
			//ip = "http://"+"10.110.2.157"+":11000/";
			ip = "http://"+"10.110.26.23"+":10002/";
			sLink= sLink.substring(sLink.indexOf("chnterm")+8,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink ="/AuthSend_chn.jsp?system_code=12345&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink ="/AuthSend_chn.jsp?system_code=12345&targeturl="+ip+sLink+query_str;
			}
		}else if( sLink.indexOf("newsaleweb") != -1 ){
    //wanglei add 营销管理分发判断
			//ip = "http://"+"10.110.0.100"+":49000/";
			//ip = "http://"+"10.110.0.204"+":10013/";
			ip = "http://"+"10.110.26.23"+":49000/";
			sLink= sLink.substring(sLink.indexOf("newsaleweb")+11,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink ="/AuthSend_newsale.jsp?system_code="+sLink+"&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink ="/AuthSend_newsale.jsp?system_code="+sLink+"&targeturl="+ip+sLink+query_str;
			}
		}else if( sLink.indexOf("ng_crm") != -1 ){
			ip = "http://"+"10.110.13.52"+":10018/";
			sLink= sLink.substring(sLink.indexOf("ng_crm")+7,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink ="/AuthSend_mkt.jsp?system_code="+sLink+"&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink ="/AuthSend_mkt.jsp?system_code="+sLink+"&targeturl="+ip+sLink+query_str;
			}
			//System.out.println("gaopengSeeLogsLink===sLink===="+sLink);
			
    }else if( sLink.indexOf("ngcrm_report") != -1 ){
			ip = "http://"+"10.110.26.23"+":50021/";
			sLink= sLink.substring(sLink.indexOf("ngcrm_report")+13,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink ="/AuthSend_mktrpot.jsp?system_code="+sLink+"&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink ="/AuthSend_mktrpot.jsp?system_code="+sLink+"&targeturl="+ip+sLink+query_str;
			}
			
    }else if( sLink.indexOf("iMktReport") != -1 ){
			ip = "http://"+"10.110.26.23"+":40021/";
			sLink= sLink.substring(sLink.indexOf("iMktReport")+11,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink ="/AuthSend_marketreport.jsp?system_code="+sLink+"&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length())+"&reportflag=1";
			}else{
				sLink ="/AuthSend_marketreport.jsp?system_code="+sLink+"&targeturl="+ip+sLink+query_str+"&reportflag=1";
			}
			
		}else if(sLink.indexOf("mktReport") != -1){
				ip = "http://"+"10.110.26.23"+":30170/";
				sLink= sLink.substring(sLink.indexOf("market")+7,sLink.length());
				if (sLink.indexOf("?") != -1 ){
					sLink ="/AuthSend_market.jsp?system_code="+sLink+"&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length());
				}else{
					sLink ="/AuthSend_market.jsp?system_code="+sLink+"&targeturl="+ip+sLink+query_str;
				}
			}else if( sLink.indexOf("newmkt") != -1 ){
			ip = "http://"+"10.110.26.23"+":30070/";

			sLink= sLink.substring(sLink.indexOf("market")+7,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink ="/AuthSend_market.jsp?system_code="+sLink+"&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink ="/AuthSend_market.jsp?system_code="+sLink+"&targeturl="+ip+sLink+query_str;
			}
			
    }else if(sLink.indexOf("mktReport") != -1){
			ip = "http://"+"10.110.26.23"+":30170/";
			sLink= sLink.substring(sLink.indexOf("market")+7,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink ="/AuthSend_market.jsp?system_code="+sLink+"&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink ="/AuthSend_market.jsp?system_code="+sLink+"&targeturl="+ip+sLink+query_str;
			}
		}else if( sLink.indexOf("market") != -1 &&  sLink.indexOf("newmkt") == -1){
			ip = "http://"+"10.110.26.23"+":30021/";
			sLink= sLink.substring(sLink.indexOf("market")+7,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink ="/AuthSend_market.jsp?system_code="+sLink+"&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length())+"&funcode="+funcode;
			}else{
				sLink ="/AuthSend_market.jsp?system_code="+sLink+"&targeturl="+ip+sLink+query_str+"&funcode="+funcode;
			}
    }else if( sLink.indexOf("parter") != -1 ){
			//ip = "http://"+"10.110.0.100"+":45000/";
			 ip = "http://"+"10.110.13.52"+":10012/";
			sLink= sLink.substring(sLink.indexOf("parter")+7,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink ="/AuthSend_parter.jsp?system_code="+sLink+"&targeturl="+ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink ="/AuthSend_parter.jsp?system_code="+sLink+"&targeturl="+ip+sLink+query_str;
			}
		}else if( sLink.indexOf("channel") != -1 ){

			//加密处理
			StringBuffer chnSb = new StringBuffer();
			int opCodeS = sLink.indexOf("[",0);
			int opCodeE = sLink.indexOf("]",0);
			String opCode = "null";
			if (opCodeE>opCodeS && opCodeS>0){
			        opCode = sLink.substring(opCodeS+1,opCodeE);
			        sLink=replace(sLink,"["+opCode+"]","");
			}
			String tmpE = funcode+",";
			tmpE = tmpE+funcname+",";
			tmpE = tmpE+workNo+",";
			tmpE = tmpE + workGroupId+",";
			tmpE = tmpE+request.getServerName();
			tmpE = tmpE+","+funcode;
			chnSb.append(sLink).append("&chnLee=").append(getHostE(tmpE));
			sLink = chnSb.toString();
			//加密处理结束

			//ip = "http://10.110.2.229:8888/";
			//ip = "http://10.110.13.52:10004/"; //liyan 20090526
				ip = "http://10.110.26.23:7989/";
			//ip = "http://10.109.222.127:9903/";
			//ip = "http://10.109.180.14:8080/"; //liyan 临时使用,新办公室
			//ip = "http://10.109.180.29:8080/"; //lijb 临时使用
			//ip = "http://10.109.223.123:8080/"; //liyan 临时使用,29号楼
			
			sLink= sLink.substring(sLink.indexOf("channel")+8,sLink.length());
			if (sLink.indexOf("?") != -1 )
			{
				sLink =ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink =ip+sLink+query_str;
			}
			//System.out.println("sLink=====linqun==============:"+sLink);

		}else if( sLink.indexOf("cardres") != -1 ){

			//加密处理
			StringBuffer chnSb = new StringBuffer();
			int opCodeS = sLink.indexOf("[",0);
			int opCodeE = sLink.indexOf("]",0);
			String opCode = "null";
			if (opCodeE>opCodeS && opCodeS>0){
			        opCode = sLink.substring(opCodeS+1,opCodeE);
			        sLink=replace(sLink,"["+opCode+"]","");
			}
			String tmpE = funcode+",";
			tmpE = tmpE+funcname+",";
			tmpE = tmpE+workNo+",";
			tmpE = tmpE + workGroupId+",";
			tmpE = tmpE+request.getServerName();
			tmpE = tmpE+","+funcode;
			chnSb.append(sLink).append("&chnLee=").append(getHostE(tmpE));
			sLink = chnSb.toString();
			//加密处理结束

			//ip = "http://10.110.0.100:43000/";
			ip = "http://10.110.13.52:10003/";
			sLink= sLink.substring(sLink.indexOf("cardres")+8,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink =ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink =ip+sLink+query_str;
			}
		}else if( sLink.indexOf("iCrmReport") != -1 ){  // add by yangxj 2009.04.30 NG_CRM统一报表

			//加密处理...
			StringBuffer chnSb = new StringBuffer();
			String tmpE = funcode+",";
			tmpE = tmpE+funcname+",";
			tmpE = tmpE+workNo+",";
			tmpE = tmpE + workGroupId+",";
			tmpE = tmpE+request.getServerName();
			tmpE = tmpE+","+funcode;
			chnSb.append(sLink).append("&chnLee=").append(getHostE(tmpE));
			sLink = chnSb.toString();
			//加密处理结束

			ip = "http://10.110.0.207:10003/" ;		// 测试环境 liyan 20090814 测试注释
			//ip = "http://10.109.180.14:7001/";

			// ip = "http://10.110.0.100:32000/" ;   	// 生产环境

			if (sLink.indexOf("?") != -1 ){
				sLink =ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink =ip+sLink+query_str;
			}

		}else if(sLink.indexOf("urms") != -1 ){ //add by 统一投诉管理    
			//System.out.println("$$$$$$$$$$$$$$$$$$######adfadfadasdasf&");
			//统一投诉系统跳转处理
            ip = "http://"+"10.110.26.23"+":6610/"; //--生产改为四层交换地址
            sLink = sLink.substring(sLink.indexOf("urms")+4,sLink.length());
            String targeturl=sLink;
			//生成摘要加密信息
            String tmpE = workNo + "," + workName + "," + orgCode + ","
                        + orgName + "," + workGroupId + ","
                         + request.getRemoteAddr();
            query_str=query_str+"&chnLee="+getHostE(tmpE);
           // System.out.println("$$$$$$$$$$$$$$$$$$######="+query_str);
			sLink=ip+"workflow/common/commonAuth.jsp"+query_str+"&targeturl="+targeturl;
        
        }else if(sLink.indexOf("uReportApp") != -1){
        	//System.out.println("$$$$$$$$$$$$$$$$$$######adfadfadasdasf&");
			//统一投诉系统跳转处理
            ip = "http://"+"10.110.26.23"+":6610/"; //--生产改为四层交换地址
            //sLink = sLink.substring(sLink.indexOf("uReportApp")+4,sLink.length());
            String targeturl=sLink;
			//生成摘要加密信息
            String tmpE = workNo + "," + workName + "," + orgCode + ","
                        + orgName + "," + workGroupId + ","
                         + request.getRemoteAddr();
            query_str=query_str+"&chnLee="+getHostE(tmpE);
           // System.out.println("$$$$$$$$$$$$$$$$$$######="+query_str);
			sLink=ip+"workflow/common/commonAuth.jsp"+query_str+"&targeturl="+targeturl;
		}else if( sLink.indexOf("chnnew") != -1 ){

			//加密处理...
			StringBuffer chnSb = new StringBuffer();
			String tmpE = funcode+",";
			tmpE = tmpE+funcname+",";
			tmpE = tmpE+workNo+",";
			tmpE = tmpE + workGroupId+",";
			tmpE = tmpE+request.getServerName();
			tmpE = tmpE+","+funcode;
			chnSb.append(sLink).append("&chnLee=").append(getHostE(tmpE));
			sLink = chnSb.toString();
			//加密处理结束


			ip = "http://10.110.13.52:10002/";
			sLink= sLink.substring(sLink.indexOf("chnnew")+7,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink =ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink =ip+sLink+query_str;
			}
		}else if( sLink.indexOf("chninfo") != -1 ){  // add by liyan 2009.07.10

			//加密处理...
			StringBuffer chnSb = new StringBuffer();
			String tmpE = funcode+",";
			tmpE = tmpE+funcname+",";
			tmpE = tmpE+workNo+",";
			tmpE = tmpE + workGroupId+",";
			tmpE = tmpE+request.getServerName();
			tmpE = tmpE+","+funcode;
			chnSb.append(sLink).append("&chnLee=").append(getHostE(tmpE));
			//System.out.println("--------------------chnSb-------------------------------------  "+chnSb);
			sLink = chnSb.toString();
			//System.out.println("--------------------sLink-------------------------------------  "+sLink);
			//加密处理结束 

			ip = "http://10.110.13.52:10017/" ;		// 测试环境
			//ip = "http://10.109.180.74:7001/" ;		// ningtn本机
		
			sLink= sLink.substring(sLink.indexOf("chninfo")+8,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink =ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink =ip+sLink+query_str;
			}
			//System.out.println("----------hejwa----------sLink-------------------------------------  "+sLink);
		}else if( sLink.indexOf("grporder") != -1 ){
			ip = "http://"+"172.16.9.37"+":16000/";
			sLink = sLink.substring(sLink.indexOf("grporder")+9,sLink.length());
			if (sLink.indexOf("?") != -1 ){
				sLink =ip+sLink+"&"+query_str.substring(1,query_str.length());
			}else{
				sLink =ip+sLink+query_str;
			}
		}else if( sLink.indexOf("oneboss") != -1 ){
			//ip = "http://"+"10.110.2.223"+":7001/";

			ip = "http://"+"10.110.13.52"+":10008/";
			sLink = sLink.substring(sLink.indexOf("oneboss")+8,sLink.length());

			if(powerCode!=null&& !powerCode.trim().equals("") ){
        	query_str +="&powerCode="+powerCode.trim();
      }

      if (powerRight!=null&& !powerRight.trim().equals("") ){
        	query_str +="&power_right="+powerRight.trim();
			}

			if (sLink.indexOf("?") != -1 )
				sLink = ip+sLink+"&"+query_str.substring(1,query_str.length());
			else
				sLink = ip+sLink+query_str;
		}else if(sLink.indexOf("callcenter") != -1 ){
			sLink = sLink.substring(sLink.indexOf("callcenter"),sLink.length());
			sLink = sLink+query_str;
			sLink = selfIPPort+"/"+sLink;
      }
      else if( sLink.indexOf("SelfTerm") != -1 ){
	
			//ip = "http://"+"10.110.0.100"+":42000/";
			//ip = "http://"+"10.110.0.206"+":40007/";
			ip = "http://"+"10.110.26.22"+":20025/";
			sLink = sLink.substring(sLink.indexOf("SelfTerm")+9,sLink.length());
			sLink=ip+"AuthCheck_ngcard.jsp"+query_str+"&resUrl="+sLink;
			sLink=sLink.replaceAll("#","%23");
	  } 
      /*added by tangsong 20110314 将206的客服部分同步到204*/
      //begin
      else if(sLink.indexOf("notices/xtree_manager_main.jsp") != -1){
              //query_str +="&kflogin_no="+workNo;
              //ip = "http://10.110.2.171";
              link = sLink+query_str+"&powerCode="+powerCodekf;
              //sLink = "http://" + ip + ":22000/" + sLink+query_str;
      //jingzhi add 2010/02/27 for kf publicNote add userID end
      }else if(sLink.indexOf("notices/xtree_user_main.jsp") != -1){
              //query_str +="&kflogin_no="+workNo;
              //ip = "http://10.110.2.171";
              link = sLink+query_str+"&powerCode="+powerCodekf;
              //sLink = "http://" + ip + ":22000/" + sLink+query_str;
      //jingzhi add 22010/02/27  for kf publicNote add userID end
      //songjia add 2010/02/27 for kf report add userID end
      }else if(sLink.indexOf("notices/npage/notices") != -1){
              link = sLink+query_str+"&powerCode="+powerCodekf;
      //songjia add 22010/02/27  for kf publicNote add userID end
		}
		//end
		
		/*add by tangsong 20110628 排班系统*/
		else if(sLink.indexOf("scheduler") != -1)     
		{
			String outcallip = "http://10.110.26.23:28001/scheduler";
			String tmplink = sLink.substring(sLink.indexOf("scheduler")+10,sLink.length());
			sLink ="/AuthSend_scheduler.jsp?system_code="+tmplink+"&targeturl="+tmplink+"&targetip="+outcallip+"&autodispatch=n";
		}
		
		else  if(sLink.indexOf("offerManage") != -1 ){
     //ip = "http://"+"10.110.0.206"+":30003";
     //ip = "http://"+"10.110.0.204"+":18001";
     ip = "http://"+"10.110.26.23"+":9888";
     sLink = sLink.substring(sLink.indexOf("offerManage")+12,sLink.length());
     sLink ="/AuthSend_offer.jsp?system_code="+sLink+"&targeturl="+ip+"&"+query_str.substring(1,query_str.length());
     //sLink ="/AuthSend_offer.jsp?system_code="+sLink+"&targeturl="+ip+"&"+query_str.substring(1,query_str.length());
     sLink = ip+sLink;
    }
	else if( sLink.indexOf("ngwebres") != -1 ){
	
			//ip = "http://"+"10.110.0.100"+":42000/";
			//ip = "http://"+"10.110.0.206"+":40007/";
			ip = "http://"+"10.110.13.52"+":10020/";
			sLink = sLink.substring(sLink.indexOf("ngwebres")+9,sLink.length());
			sLink=ip+"AuthCheck_ngcard.jsp"+query_str+"&resUrl="+sLink;
			sLink=sLink.replaceAll("#","%23");
	} else if("b666".equals(funcode)||"b667".equals(funcode)||"b668".equals(funcode)||"b669".equals(funcode)
		||"b670".equals(funcode)||"b671".equals(funcode)||"b672".equals(funcode)){
			ip = "http://"+"10.110.26.23"+":30042/";	//测试
			//ip = "http://10.110.0.126:24000/";	//生产
			sLink = ip+sLink.substring(sLink.indexOf("check.jsp"),sLink.length());
			//System.out.println("chenki===================="+sLink);
	} else if("b774".equals(funcode)||"b775".equals(funcode)||"b776".equals(funcode)||"b801".equals(funcode)
		||"b802".equals(funcode)||"b803".equals(funcode)||"b804".equals(funcode)){
    //sLink= "http://10.110.0.206:6600/workflow/swf160/swf160Frame.jsp?&opCode=b774&opName=活动工单查询";
    //统一投诉系统跳转处理
    ip = "http://"+"10.110.26.23"+":6600/"; //测试
    //ip = "http://10.110.0.100:21000/"; //生产
    sLink = sLink.substring(sLink.indexOf("workflow")+8,sLink.length());
    String targeturl="/workflow"+sLink;
	  //生成摘要加密信息
    String tmpE = workNo + "," + workName + "," + orgCode + ","
                  + orgName + "," + workGroupId + ","
                  + request.getRemoteAddr();
    query_str=query_str+"&chnLee="+getHostE(tmpE);
	  sLink=ip+"workflow/common/commonAuth.jsp"+query_str+"&targeturl="+targeturl;
	  //System.out.println("chenki===================="+sLink);
  }else  if(sLink.indexOf("srvgis") != -1 ){
			ip = "http://"+"10.110.13.52"+":10030";
			sLink = sLink.substring(sLink.indexOf("srvgis")+6,sLink.length());
			//sLink = ip+sLink;
			String targeturl=sLink;
			//生成摘要加密信息
			String tmpE = workNo + "," + workGroupId + "," + request.getRemoteAddr();
			query_str = query_str + "&chnLee="+getHostE(tmpE);
			sLink=ip+"/comframe/commonAuth.jsp"+query_str+"&targeturl="+targeturl;
			//System.out.println("ningtn===================="+sLink);
  }else  if(sLink.indexOf("srvpre") != -1 ){
	   ip = "http://"+"10.110.26.23"+":28001/predeal";
	   sLink = sLink.substring(sLink.indexOf("srvpre")+6,sLink.length());
	   sLink = ip+sLink;
	   //System.out.println("ningtn===================="+sLink);
  }else  if(sLink.indexOf("chnrwd") != -1 ){
	   ip = "http://"+"10.110.26.23"+":7989";
	   sLink = sLink.substring(sLink.indexOf("chnrwd")+6,sLink.length());
	   sLink = ip+sLink;
	   
	   String tmpE = workNo + "," + workName + "," + orgCode + ","
                  + orgName + "," + workGroupId + ","
                  + request.getRemoteAddr();
	    query_str=query_str+"&chnLee="+getHostE(tmpE);
		  sLink=sLink+query_str;
	   
	   //System.out.println("ningtn===================="+sLink);
  }
  else  if(sLink.indexOf("newrwd") != -1 ){
	   ip = "http://10.110.2.203"+":7989";
	   sLink = sLink.substring(sLink.indexOf("newrwd")+6,sLink.length());
	   sLink = ip+sLink;
	   
	   String tmpE = workNo + "," + workName + "," + orgCode + ","
                  + orgName + "," + workGroupId + ","
                  + request.getRemoteAddr();
	    query_str=query_str+"&chnLee="+getHostE(tmpE);
		  sLink=sLink+query_str;
	   
	   //System.out.println("ningtn===================="+sLink);
  }
  else  if(sLink.indexOf("hallmanage") != -1 ){
	   ip = "http://"+"10.110.13.52"+":10076/hallmanage/simplesso/simplessoIn";
	   //ip = "http://"+"127.0.0.1"+":8000/WebRoot/simplesso/simplessoIn";
	   sLink = sLink.substring(sLink.indexOf("hallmanage")+10,sLink.length());
	   sLink = ip+"/"+encrypt(workNo)+"/"+encrypt(nopass)+"/"+encrypt(sLink);
	   //sLink = ip+"/"+workNo+"/"+nopass+"/"+"977ad16f6f207ac98b7bc1e01256d2c5ba77e980a33ad1a5bb824a5b253f1661";
	   //sLink = ip+"?loginNo="+workNo+"&passWord="+nopass+"&url="+"977ad16f6f207ac98b7bc1e01256d2c5ba77e980a33ad1a5bb824a5b253f1661";
	   //System.out.println("gaopeng===================="+sLink);
  }
  //else if(sLink.indexOf("f4929.jsp") != -1 || sLink.indexOf("f4930.jsp") != -1|| sLink.indexOf("f4932.jsp") != -1|| sLink.indexOf("f9908.jsp") != -1){
//  	ip = "http://"+"10.110.26.23"+":28001/page/";
//  	System.out.println("gaopengSeeLog========sLink:"+sLink);
//  	sLink = ip + sLink;
//  }
  else  if(sLink.indexOf("cmdb") != -1 ){
	   ip = "http://10.110.16.100:10087/cmdb/bomcprocess.jsp?login_no=";
	   sLink = sLink.substring(sLink.indexOf("cmdb")+5,sLink.length());
	   sLink = ip+workNo;
  }  
  else  if(sLink.indexOf("giftweb") != -1 ){
		ip = "http://10.110.13.52:10086/";
		sLink= sLink.substring(sLink.indexOf("giftweb")+8,sLink.length());
		sLink=ip+"AuthCheck_nggift.jsp"+query_str+"&resUrl="+sLink;
		sLink=sLink.replaceAll("#","%23");
  }
  
  else  if(sLink.indexOf("termweb") != -1 ){
  
		ip = "http://10.110.13.52:10101/";
		sLink= sLink.substring(sLink.indexOf("termweb")+8,sLink.length());
		sLink=ip+"AuthCheck_ngterm.jsp"+query_str+"&resUrl="+sLink;
		sLink=sLink.replaceAll("#","%23");
		/**/
  }
  /*2015/12/7 11:14:06 gaopeng 量化薪酬系统*/
  else  if(sLink.indexOf("chnscv") != -1 ){
  	/*测试环境*/
		ip = "http://10.110.13.52:50001/";
		sLink= sLink.substring(sLink.indexOf("chnscv")+7,sLink.length());
		sLink=ip+sLink+"?service_no="+workNo+"&group_id="+groupId;
		sLink=sLink.replaceAll("#","%23");
		//System.out.println("gaopengchnscv===================="+sLink);
  }
  
else if( sLink.indexOf("pim") != -1 ){
  //System.out.println("obim=============<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<============"+sLink);
ip = "http://"+"10.110.26.27"+":16001";
//sLink= sLink.substring(sLink.indexOf("pim")+3,sLink.length());
//sLink=ip+"?systemUserCode="+workNo+"&funcAction="+sLink;
sLink=ip+"/npage/obim/common/crm_common.jsp?systemUserCode="+workNo+"&funcAction=npage/"+sLink;
//sLink ="/AuthSend_pim.jsp?system_code="+sLink+"&targeturl="+ip+"/npage/"+sLink;

  //System.out.println("bim=============<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<============"+sLink);

}
  else  if(sLink.indexOf("electrManage") != -1 ){
//ip = "http://"+"10.110.0.100"+":59000";
ip = "http://"+"10.110.13.52"+":8899";
 sLink = sLink.substring(sLink.indexOf("electrManage")+12,sLink.length());
 sLink = ip+sLink+"&opcode="+funcode+"&workNo="+workNo+"&workName="+workName;

	//System.out.println("wanghydsss===================="+sLink);
}else if(sLink.indexOf("orderManager") != -1 ){
	//hejwa add R_CMI_HLJ_xueyz_2013_1235107@网上选号物流配送对接物流平台改造 调用下单、回单模块
	ip = "http://"+"10.110.26.31"+":10011/";
	//生产环境
	//ip = "http://"+"10.110.2.229"+":21001/";
	
	/*2014/07/28 10:57:59 gaopeng 关于在CRM系统中开发电商线上订单查询页面和增加客户下行通知短信的需求上线待办事宜 */
	if(sLink.indexOf("do_showOrderQryByCrm") != -1 ){
		/*测试环境*/
		ip = "http://"+"10.111.67.208"+":10110/";
		/*生产环境*/
		//ip = "http://"+"10.111.67.139"+":8091/";
		sLink = sLink +"?loginNo="+workNo+"&loginPwd="+nopass;
		//System.out.println("gaopengSeeLog===0601==="+sLink);
		
	}
	/*2014/12/17 17:10:46 gaopeng 于在CRM系统中开发外部电商物流下单页面的需求 */
	if(sLink.indexOf("deliverOrderList.do") != -1 ){
		/*测试环境*/
		ip = "http://"+"10.111.67.140"+":8089/";
		/*生产环境*/
		//ip = "http://"+"10.111.67.140"+":8089/";
		sLink = sLink.replaceFirst("orderManager/","");
		sLink = sLink +"?loginNo=0B436BD3C6A0A881&loginPwd=545EF5BB80F046A8";
		
	}
	/*2016/8/22 16:20:25  电商微信支付报表*/
	if(sLink.indexOf("getPayOrderInfoByWeiXin") != -1 ){
		/*测试环境*/
		ip = "http://"+"10.111.67.139"+":8091/";
		/*生产环境*/
		ip = "http://"+"10.111.67.139"+":8091/";
		sLink = sLink.replaceFirst("orderManager/","");
		//sLink = sLink +"?loginNo=0B436BD3C6A0A881&loginPwd=809AF04390889B5789AC7B375DE298F5";
		
	}
	
	if(sLink.indexOf("ecosp-console-web") != -1 ){
		/*测试环境*/
		ip = "http://"+"10.111.67.209"+":10089/";
		/*生产环境*/
		//ip = "http://"+"10.111.67.139"+":8091/";
		sLink = sLink.replaceFirst("orderManager/","");
		
	}
	
	sLink = ip+	sLink;
	
	//System.out.println("hejwa1==="+sLink);
}else if(sLink.indexOf("CCPS/IA") != -1 ){
	/*hejwa add  2013年12月31日16:40:38 NG4.0项目-渠道协同分册，需要单点登录*/
	//测试环境
	ip = "http://"+"10.110.26.31"+":10011/";
	sLink ="/AuthSend_CCPS.jsp?system_code="+sLink;
	//System.out.println("hejwa---ccps-渠道协同------"+sLink);
}else if(sLink.indexOf("maccmanage") != -1 ){
	/*集中台账管理*/
	ip = "http://"+"10.110.26.23"+":12837/";
	/*2015/02/05 14:28:54 gaopeng 生产地址
		ip = "http://"+"10.110.2.229"+":12000/";
	*/
	sLink = ip+	"npage/login/index.jsp?encrystring=";
	String paramsStr = "login_no="+workNo+"&group_id="+workGroupId+"&opcode="+funcode+"&group_name="+"workGroupId"+"&op_name="+funcname;
	sLink = sLink + getHostE(paramsStr);
	//System.out.println("wanglqa sLink==="+sLink);
}else  if(sLink.indexOf("smartTerm") != -1 ){
		ip = "http://10.110.13.52:10101/";
		sLink= sLink.substring(sLink.indexOf("smartTerm")+10,sLink.length());
		sLink=ip+"AuthCheck_smartTerm.jsp"+query_str+"&resUrl="+sLink;
		sLink=sLink.replaceAll("#","%23");
  }else if(sLink.indexOf("property") != -1 ){
		/*资产管理*/
		ip = "http://10.110.26.27:8001";
		sLink = ip+	sLink;
		String paramsStr = "&username="+workNo+"&password="+nopass+"&group_id="+workGroupId+"&workName="+workName;
		sLink = sLink + paramsStr;
		//System.out.println("ningtn sLink==="+sLink);
	}else if(sLink.indexOf("predeal") != -1 ){
		/*客服投诉导航*/
		//测试
		ip = "http://10.110.26.23:30100";
		//生产
		//ip = "http://10.110.0.100:17010";
		sLink = ip+	sLink;
		String paramsStr = "&username="+workNo+"&password="+nopass+"&group_id="+workGroupId+"&workName="+workName;
		sLink = sLink + paramsStr;
		//System.out.println("ningtn sLink==="+sLink);
	}
	else if(sLink.indexOf("iomWeb") != -1 ){
		/*pboss2.0*/
		//测试
		ip = "http://10.110.26.27:9003";
		//生产
		//ip = "http://10.110.0.100:17010";
		sLink = ip+	sLink;
		String regionInfo	= (String)session.getAttribute("regionInfo");
		String areaInfo		= (String)session.getAttribute("areaInfo");
		String hallInfo		= (String)session.getAttribute("hallInfo");
		String[] localNetArr = regionInfo.split("\\|");
		String[] areaArr = areaInfo.split("\\|");
		//本地网ID
		String localNetId = "";
		//本地网名称
		String localNetName = "";
		//服务区ID
		String areaId = "";
		//服务区名称
		String areaName = "";
		if(localNetArr.length == 2){
			localNetId = localNetArr[1];
			localNetName = localNetArr[0];
		}
		if(areaArr.length == 2){
			areaId = areaArr[1];
			areaName = areaArr[0];
		}
		//System.out.println("---------- ningtn PBOSS2.0 regionInfo=" + regionInfo);
		//System.out.println("---------- ningtn PBOSS2.0 areaInfo=" 	+ areaInfo);
		//System.out.println("---------- ningtn PBOSS2.0 hallInfo=" 	+ hallInfo);
		//System.out.println("---------- ningtn PBOSS2.0 localNetArr=" 	+ localNetArr.length);
		//System.out.println("---------- ningtn PBOSS2.0 areaArr=" 	+ areaArr.length);
		String paramsStr = "?staffCode="+workNo
												+"&staffName="+workName
												+"&localNetId="+localNetId
												+"&localNetName="+localNetName
												+"&areaId="+areaId
												+"&areaName="+areaName
												+"&commonRegionId="+workGroupId
												+"&authType=simple"
												+"&actionName=" + funcname
												+"&opCode=" + funcode
												;
		sLink = sLink + paramsStr;
		//System.out.println("ningtn sLink==="+sLink);
	}
	else if(sLink.indexOf("irmsClient") != -1 ){
		/*PBOSS资源管理*/
		//测试
		ip = "http://10.110.26.27:10007";
		//生产
		//ip = "http://10.110.0.100:17010";
		sLink = ip+	sLink;
		String paramsStr = "?login_no="+workNo+"&password="+nopass+"&work_group_id="+workGroupId+"&login_name="+workName+"&funcode="+funcode;
		sLink = sLink + paramsStr;
		//System.out.println("ningtn sLink==="+sLink);
	}else  if(sLink.indexOf("termsvweb") != -1 ){
		/* 终端售后维护系统 */
		//测试环境
		ip = "http://10.110.13.52:10085/TermService/";
		//生产环境
		//ip = "http://10.110.0.100:47301/";
		sLink= sLink.substring(sLink.indexOf("termsvweb")+10,sLink.length());
		sLink=ip+"AuthCheck_ngTerm.jsp"+query_str+"&resUrl="+sLink;
		sLink=sLink.replaceAll("#","%23");
  }else  if(sLink.indexOf("mnp_mng") != -1 ){
		/* 改造提醒短信承载营销宣传信息的方案 */
		//测试环境
		ip = "http://10.110.26.22:7031/mnp_mng/page/hljmarket/";
		//生产环境
		//ip = "http://10.110.2.229:60001/mnp_mng/page/hljmarket/";
		sLink= sLink.substring(sLink.indexOf("mnp_mng")+8,sLink.length());
		sLink=ip+sLink + "?action=query&loginNo=" + workNo;
		sLink=sLink.replaceAll("#","%23");
		//System.out.println("ningtienan sLink " + sLink);
  }else  if(sLink.indexOf("itresweb") != -1 ){/*光猫管理系统跳转页面地址*/
		ip = "http://10.110.0.100:10031/";
		sLink= sLink.substring(sLink.indexOf("itresweb")+9,sLink.length());
		sLink=ip+"AuthCheck_itres.jsp"+query_str+"&resUrl="+sLink;
		sLink=sLink.replaceAll("#","%23");
  }
  
 else {
			sLink=selfIPPort+"/page/"+sLink;
}
	//打开方式 1.一级tab打开;2.二级tab打开;其他值为弹出方式
	if(openFlag.equals("1"))
	{
		return link;
	}else if(openFlag.equals("2"))
	{
		return link;
	}else
	{
			return sLink;
	}

}
%>
