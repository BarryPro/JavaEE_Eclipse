<%
    /*************************************
    * 功  能: 一点支付成员清单查询 展示明细 g087
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-9-13
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%
  response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
%>
<%
  String regCode = (String)session.getAttribute("regCode");
  String loginNo = (String)session.getAttribute("workNo");
  String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
  String opName = WtcUtil.repNull((String)request.getParameter("opName"));
  String idNo = WtcUtil.repNull((String)request.getParameter("idNo"));/*用户idNo*/
  String accountNo = WtcUtil.repNull((String)request.getParameter("accountNo"));/*产品账号*/
  String monthList = WtcUtil.repNull((String)request.getParameter("monthList"));/*操作年月：yyyyMM */
  String qryPhoneNo = WtcUtil.repNull((String)request.getParameter("qryPhoneNo"));
  DecimalFormat numFormat  =   new  DecimalFormat("##0.00");  
  
  /*表名：dCustOwe+年月+账号后两位*/
  String operateTableName = "dCustOwe"+monthList+(accountNo.substring(accountNo.length()-2,accountNo.length()));
  
  /* 获取本期代付额 */
  String  inParams [] = new String[2];
  inParams[0] = "select nvl(to_char(sum(a.should_pay-a.favour_fee)),0.00) from "+operateTableName+" a where a.id_no=:idno and a.contract_no=:contractno";
  inParams[1] = "idno="+idNo+",contractno="+accountNo;
  
  String period_fee = "";
%>  
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
<wtc:param value="<%=inParams[0]%>"/>
<wtc:param value="<%=inParams[1]%>"/> 
</wtc:service>  
<wtc:array id="ret"  scope="end"/>
<%
if("000000".equals(retCode1)){
  if(ret.length>0){
    period_fee = numFormat.format(Float.parseFloat(ret[0][0]));
  }
}else{
%>
    <SCRIPT language="JavaScript">
      rdShowMessageDialog("错误代码：<%=retCode1%><br>错误信息：<%=retMsg1%>",0);
      window.close();
    </SCRIPT>
<%
  System.out.println("------获取不到本期代付额-----period_fee="+period_fee);
}
  System.out.println("------本期代付额-----period_fee="+period_fee);
%>

<wtc:service name="se610SQ" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="18">
	<wtc:param value="<%=qryPhoneNo%>"/>
	<wtc:param value="<%=monthList%>"/> 
	<wtc:param value="<%=loginNo%>"/>
</wtc:service>
<wtc:array id="result"  scope="end"/>

<HTML>
  <HEAD>
  </HEAD>
  <BODY>
    <%
    if("000000".equals(retCode2)){
    %>
  <div id="Main">
    <DIV id="Operation_Table">
      <div class="title">
        <div id="title_zi">中国移动通信集团客户成员账单一点支付——成员清单</div>
      </div>
        <table>
          <tr>
            <th>手机号码</th>
            <th>省份</th>
            <th>本期代付额</th>
            <th>套餐及固定费</th>
            <th>语音通讯费</th>
            <th>上网费</th>
            <th>短信/彩信费</th>
            <th>增值业务费</th>
            <th>代收业务费</th>
            <th>其他费用</th>
            <th>优惠及减免</th>
            <th>总计</th>
          </tr>
        <%
        		if(result.length==0){
        			out.println("<tr height='25' align='center'><td colspan='12'>");
        			out.println("没有任何记录！");
        			out.println("</td></tr>");
        		}else if(result.length>0){
        			String tbclass = "";
        			for(int i=0;i<result.length;i++){
        					tbclass = (i%2==0)?"Grey":"";
        					float addValueFee = Float.parseFloat(result[i][11])+Float.parseFloat(result[i][12]);
                  //float addValueFeeFormat = (float)(Math.round(addValueFee*100))/100;
        					float anotherValues = Float.parseFloat(result[i][8])+Float.parseFloat(result[i][13])+Float.parseFloat(result[i][15]);
        					//float anotherValuesFormat = (float)(Math.round(anotherValues*100))/100;
        					
        					   
                  String  addValueFeeFormat = numFormat.format(addValueFee);    
                  String  anotherValuesFormat = numFormat.format(anotherValues); 
                  
                   System.out.println("------addValueFee="+addValueFee+"---------------addValueFeeFormat="+addValueFeeFormat);
                   System.out.println("------anotherValues="+anotherValues+"---------------anotherValuesFormat="+anotherValuesFormat);
                  
                  String sumFeeFormat = numFormat.format(Float.parseFloat(result[i][3]));
        %>
        			<tr align="center" id="row_<%=i%>">
        				<td class="<%=tbclass%>"><%=qryPhoneNo%></td>
        				<td class="<%=tbclass%>">黑龙江</td>
        				<td class="<%=tbclass%>"><%=period_fee%></td>
        				<td class="<%=tbclass%>"><%=result[i][6]%></td>
        				<td class="<%=tbclass%>"><%=result[i][7]%></td>
        				<td class="<%=tbclass%>"><%=result[i][9]%></td>
        				<td class="<%=tbclass%>"><%=result[i][10]%></td>
        				<td class="<%=tbclass%>"><%=addValueFeeFormat%></td>
        				<td class="<%=tbclass%>"><%=result[i][14]%></td>
        				<td class="<%=tbclass%>"><%=anotherValuesFormat%></td>
        				<td class="<%=tbclass%>"><%=result[i][5]%></td>
        				<td class="<%=tbclass%>"><%=sumFeeFormat%></td>
        			</tr>
        <%
        			}
        		}
        %>
        </table>
       
        <table>
        <tr>
          <td align="center" id="footer" colspan="12">
            <input class="b_foot" id=closebtn type=button value="关闭" onClick="window.close()">
          </td>
        </tr>
        </table>
     </div>
  </div>
 <%}else{
    System.out.println("-------报错了！！！----retCode2="+retCode2+"------------retMsg2="+retMsg2);
  %>
      <SCRIPT language="JavaScript">
        rdShowMessageDialog("错误代码：<%=retCode2%><br>错误信息：<%=retMsg2%>",0);
        window.close();
      </SCRIPT>
  <%
  }
  %>
  </BODY>
</HTML>