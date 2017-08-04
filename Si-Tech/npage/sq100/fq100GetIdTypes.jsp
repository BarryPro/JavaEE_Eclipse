
<%
	/*
	 * 关于实名制工作需求整合的函
	 * 修改原有界面的查询服务为ajax查询服务，否则没法处理
	 * 日期: 2013/11/07 16:53:57
	 * 作者: gaopeng
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);

	String currentMonth = new java.text.SimpleDateFormat("MM",
			Locale.getDefault()).format(new java.util.Date());
	String currentYear = new java.text.SimpleDateFormat("yyyy",
			Locale.getDefault()).format(new java.util.Date());

	String opCode = (String) request.getParameter("opCode");
	String opName = (String) request.getParameter("opName");

	String workNo = (String) session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");
	String regionCode = (String) session.getAttribute("regCode");
		
		String str_isCslass740 = "0";
		String sql_isCslass740 = " select to_char(count(*)) as isCslass740  "+
											" from DBCUSTADM.dchngroupmsg a, dloginmsg b  "+
											" where a.group_id = b.group_id and class_code in (select class_code from schnclassinfo where parent_class_code = '740')  "+
											" and b.login_no = :workNo ";
		String sql_param = "workNo="+workNo;										

System.out.println("-------hejwa1100-----------sql_isCslass740-------------->"+sql_isCslass740);
System.out.println("-------hejwa1100-----------sql_param-------------------->"+sql_param);

%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql_isCslass740%>" />
		<wtc:param value="<%=sql_param%>" />	
	</wtc:service>
	<wtc:array id="result_isCslass740" scope="end"  />

<%	
	
	if(result_isCslass740.length>0){
		str_isCslass740 = result_isCslass740[0][0];
	}
System.out.println("-------hejwa1100-----------str_isCslass740-------------->"+str_isCslass740);
	//String phoneNo = (String)request.getParameter("phoneNo");
	String workChnFlag = (String) request.getParameter("workChnFlag");
	String checkVal = (String) request.getParameter("checkVal");
	System.out.println("zhouby======checkVal="+checkVal);
	System.out.println("zhouby======workChnFlag="+workChnFlag);
	/*2014/9/3 9:26:54 gaopeng 哈分公司申请优化开户名称限制的请示 获取优惠权限*/
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	String[] feeFav = new String[1];
	feeFav[0] = "";
	String tempStr = "";
	for(int feefavi = 0; feefavi< favInfo.length; feefavi++){
				tempStr = (favInfo[feefavi][0]).trim();
				System.out.println("----gaopengSeeLog---- fav -- " + tempStr);
				if(tempStr.compareTo("a987") == 0){
				/*外国公民护照优惠*/
					feeFav[0] = favInfo[feefavi][0];
				}
	}
	for(int feei = 0; feei < feeFav.length; feei++){
				System.out.println("====gaopengSeeLog=== fav feefav ===== " + feeFav[feei]);
	}
	
	
	
	String retCode1 = "";
	String retMsg1 = "";

	String opnote = workNo + "进行" + opCode + "操作";
 
	String sqlStr3 = "select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType " + " where 1=1 ";
	if (!"".equals(workChnFlag) && workChnFlag != null) {
		if (workChnFlag.equals("1")) {// “1”代表渠道工号
			/**/
			System.out.println("gaopengSeeLog====opCode="+opCode);
			if("1100".equals(opCode)){
				sqlStr3 = sqlStr3 + " and id_type in ('0', '8', 'A', 'B', 'C', '6') ";
				if(WtcUtil.haveStr(feeFav,"a987")){
					sqlStr3 = sqlStr3 + " and id_type in ('0', '8', 'A', 'B', 'C', '6') ";
				}else{
					sqlStr3 = sqlStr3 + " and id_type in ('0', '8', 'A', 'B', 'C') ";
				}
				
				if(!"0".equals(str_isCslass740)){
					//加盟店不走 a987 权限
					sqlStr3 = sqlStr3 + " or id_type in ('0', '8', 'A', 'B', 'C', '6') ";
				}
				
				
			}
			else if ("m108".equals(opCode) || "m109".equals(opCode) || "m349".equals(opCode)|| "e972".equals(opCode)|| "i067".equals(opCode)){
			  if(WtcUtil.haveStr(feeFav,"a987")){
					sqlStr3 = sqlStr3 + " and id_type in ('0', '8', 'A', 'B', 'C','D', '6') ";
				}else{
					sqlStr3 = sqlStr3 + " and id_type in ('0', '8', 'A', 'B', 'C','D') ";
				}
			} else {
			   	sqlStr3 = sqlStr3 + " and id_type in ('0') ";
			   
			}
		} else {
			if("1100".equals(opCode)||"m349".equals(opCode)){
				sqlStr3 = sqlStr3 + " and id_type not in ('7','9','1','4') ";
			}
			else{
				sqlStr3 = sqlStr3 + " and id_type not in ('7','9') ";
			}
			System.out.println("-----------------------");
		}
	}
	else{
		if("1238".equals(opCode)||"m058".equals(opCode)){
			sqlStr3 = sqlStr3 + " and id_type not in ('1','4') ";
		}
	}
	sqlStr3 = sqlStr3 + " order by id_type";
	
	System.out.println("hejwa1100========workChnFlag=="+workChnFlag);
	System.out.println("hejwa1100========sqlStr3=="+sqlStr3);
	System.out.println("hejwa1100========opCode=="+opCode);
%>

<wtc:pubselect name="sPubSelect" routerKey="region"
	routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3"
	outnum="3">
	<wtc:sql><%=sqlStr3%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result3" scope="end" />
<body>
	<%
		if ("1100".equals(opCode) || "1993".equals(opCode)|| "m108".equals(opCode) || "m109".equals(opCode) || "m349".equals(opCode)|| "e972".equals(opCode)|| "i067".equals(opCode)) {
			if("1100".equals(opCode)){
	%>
				<select align="left" name=idType id="idTypeSelect"
		onChange="change_idType('1')" width=50>
	<%
			}else{
%>
	<select align="left" name=idType id="idTypeSelect"
		onChange="change_idType()" width=50>
		<%
			}
		} else {
				if("1238".equals(opCode) || "m058".equals(opCode)){
				%>
		<select align="left" name="idType" id="idType"
		onChange="change_idType('1')" width=50 index="18">
			<%
				}else{
				%>
		<select align="left" name="idType" id="idType"
		onChange="change_idType()" width=50 index="18">
			<%
				}
	 }
			if (retCode3.equals("000000") && result3.length > 0) {
					for (int i = 0; i < result3.length; i++) {
						//普通客户 当“个人开户分类”为“普通客户”时，只可以看见：身份证0、军官证1、户口簿2、港澳通行证3、警官证4、台湾通行证5、外国公民护照6。
						if ("1238".equals(opCode) || "1100".equals(opCode)|| "m058".equals(opCode) || "m108".equals(opCode) || "m109".equals(opCode) || "m349".equals(opCode)|| "e972".equals(opCode)|| "i067".equals(opCode)) {
							if ("0".equals(checkVal)) {// “0”代表普通开户
								if ("0".equals(result3[i][0])
										|| "1".equals(result3[i][0])
										|| "2".equals(result3[i][0])
										|| "3".equals(result3[i][0])
										|| "4".equals(result3[i][0])
										|| "5".equals(result3[i][0])
										|| "6".equals(result3[i][0])
										|| "D".equals(result3[i][0])) {
									if (i == 0) {
										System.out.println("chenleikaishi1111========sqlStr3=="+result3[i][1]);
              			%>
              			<option class="button" value="<%=result3[i][0]%>|<%=result3[i][2]%>" selected><%=result3[i][1]%></option>
              			<%
          				} else {
          					System.out.println("chenleikaishi2222========sqlStr3=="+result3[i][1]);
              			%>
              			<option class="button" value="<%=result3[i][0]%>|<%=result3[i][2]%>"><%=result3[i][1]%></option>
              			<%
          				}
								}
							}else if ("1".equals(checkVal)) {//“1” 代表 “单位开户”
  								if ("8".equals(result3[i][0])
  										|| "A".equals(result3[i][0])
  										|| "B".equals(result3[i][0])
  										|| "C".equals(result3[i][0])) {
  									if (i == 0) {
                  			%>
                  			<option class="button" value="<%=result3[i][0]%>|<%=result3[i][2]%>"
                  				selected><%=result3[i][1]%></option>
                  			<%
              			} else {
                  			%>
                  			<option class="button" value="<%=result3[i][0]%>|<%=result3[i][2]%>"><%=result3[i][1]%></option>
                  			<%
              			}
  								}
							}
						} else if("1993".equals(opCode)){/*集团客户开户只能看见 营业执照、组织结构代码、单位法人证书和单位证明*/
  						if ("8".equals(result3[i][0])
  										|| "A".equals(result3[i][0])
  										|| "B".equals(result3[i][0])
  										|| "C".equals(result3[i][0])){
  							if (i == 0) {
            			%>
            			<option class="button" value="<%=result3[i][0]%>|<%=result3[i][2]%>"
            				selected><%=result3[i][1]%></option>
            			<%
            		} else {
            			%>
            			<option class="button" value="<%=result3[i][0]%>|<%=result3[i][2]%>"><%=result3[i][1]%></option>
            			<%
            		}
  						}
						}
					}
				} else {
					System.out.println("调用服务失败！");
				}
			%>
	</select>
</body>
</html>