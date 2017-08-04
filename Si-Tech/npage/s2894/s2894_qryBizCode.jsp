 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		
		String opCode = "3052";		
		String opName = "业务代码与资费关系维护";	//header.jsp需要的参数 	
		
		String regionCode= (String)session.getAttribute("regCode");		
	
		//SPubCallSvrImpl impl = new SPubCallSvrImpl();
		//ArrayList retList1 = new ArrayList();  
		String sqlStr1="";
		
		String spCode =request.getParameter("spCode");
		String bizType =request.getParameter("bizType");


		String[] inParams = new String[2];
		/*sqlStr1 =  "select a.oper_id,a.bizcode,a.bizname,a.BaseServCode from dBaseEcSIBusi a,DPARTEROPERATION c "
             +"where  a.oper_id=c.oper_id and c.status='02' "
             +"and (to_char(a.unit_id)=:spCode or a.ecsiid=:spCode) ";*/
             /*
           sqlStr1 = " select a.PRODUCT_CODE, a.bizcodeadd, a.bizname, a.ACCESSNUMBER "
					+"  from sbillspcode a, DPARTEROPERATION c "
					+" where a.PRODUCT_CODE = c.oper_id "
					+"   and c.status = '02' "
					  +" and (exists (select 1 from dgrpcustmsg d ,dbvipadm.dgrpcustmsgadd f where d.cust_id = f.cust_id and trim(a.ENTERPRICE_CODE) = f.field_value and f.field_code = 'HYWG0' and d.unit_id =:spCode) or a.ENTERPRICE_CODE = :spCode) ";
     				 */
     				 sqlStr1 = " select a.PRODUCT_CODE, a.bizcodeadd, a.product_note, a.ACCESSNUMBER "
										  +" from sbillspcode a, DPARTEROPERATION c "
											+" where a.PRODUCT_CODE = c.oper_id "
											+" and c.status = '02' "
											+" and trim(a.ENTERPRICE_CODE) = :spCode ";
     if(bizType.equals("0"))
		{
		 inParams[0]=sqlStr1+ " order by a.ENTERPRICE_CODE,a.BIZCODEADD";
		}else{
			inParams[0]=sqlStr1+ " order by a.BIZCODEADD";
		}
    inParams[1] = "spCode="+spCode;

%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service> 
	<wtc:array id="retListString1" scope="end" />	
<%
		//retList1 = impl.sPubSelect("4",sqlStr1,"region",impRegion);
		//String[][] retListString1 = (String[][])retList1.get(0);
		//int errCode=impl.getErrCode();
		//String errMsg=impl.getErrMsg();
		
	  	String op_name = "业务信息列表";

%>

<html>
	<head>
		<title><%=op_name%></title>
		<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
			window.onkeydown(window.event) 
		</SCRIPT>	
	</head>
<body>
	<form name="frm" method="POST" >
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>		
		<table id="tab1"  cellspacing="0">
			<tr align="center">
				<th>
					选择
				</th>
				<th>业务代码</th>
				<th>业务名称</th>
				<th>基本接入号</th>
			</tr>
		</table>
	<table  cellspacing="0">
		<tr>
			<td id="footer">
					
				      <input type="button" class="b_foot" name="commit" onClick="doCommit();" value=" 确定 ">
				      &nbsp;
				      <input type="button" class="b_foot" name="back" onClick="doClose();" value=" 关闭 ">
			   
			</td>
		</tr>
	</table>
	 <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>
<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="hidProdCode" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="bizCode" value="<%=retListString1[i][1]%>">';
			str+='<input type="hidden" name="bizName" value="<%=retListString1[i][2]%>">';
		
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  //newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][1]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][2]%>';
		  newrow.insertCell(3).innerHTML = '<%=retListString1[i][3]%>';
		<%}%>

		function doCommit()
		{
			
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("请选择一条记录！");
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//值为一条时不需要用数组
				if(document.all.num.checked){
					window.opener.form1.hidProdCode.value=document.all.hidProdCode.value;
					window.opener.form1.bizCode.value=document.all.bizCode.value;
					window.opener.form1.bizName.value=document.all.bizName.value;	
					window.opener.checkBizCode(document.all.bizCode.value);
				}
				else{
					
					rdShowMessageDialog("请选择一条记录！");
					return false;
				}
			}
			else{//值为多条时需要用数组				
				var a=-1;
				for(i=0;i<document.all.num.length;i++){
					if(document.all.num[i].checked){						
						a=i;
						window.close();		
						break;
					}
				}
				if(a!=-1){
					window.opener.form1.hidProdCode.value=document.all.hidProdCode[a].value;
					window.opener.form1.bizCode.value=document.all.bizCode[a].value;
					window.opener.form1.bizName.value=document.all.bizName[a].value;
					window.opener.findSm();
					window.opener.checkBizCode(document.all.bizCode[a].value);
                    			window.close();				
				}
				else{
					rdShowMessageDialog("请选择一条记录！");
					return false;
				}
			}			
			window.close();			
		}
	
	function doClose()
	{
		window.close();
	}
</script>
                                                                                                
