<% //�޸��� xingzhan 20090225 ���һ���������ڰ�ť %>
<%
   /*
   * �޸���ʷ
   * �޸����� 2009��05��13��     �޸��� libina      �޸�Ŀ��  �ı�ģ��˳��
 ��*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
  String phoneNo = (String)session.getAttribute("activePhone");
%>

<%
     String workNo = (String)session.getAttribute("workNo");
		 String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
     
     String phone_no = (String)session.getAttribute("activePhone");
     
	String cust_name       = "";
	String id_name         = "";
	String id_iccid        = "";
	String contact_person  = "";
	String contact_phone   = "";
	String contact_address = "";
	String contact_post    = "";
	String linkman_name    = "";
	String linkman_idiccid = "";
	String assure_name     = "";
	String assure_id       = "";
	String vphone_no        = "";
	String open_time       = "";
	String sm_code         = "";
	String card_name       = "";
	String product_name    = "";
	String town_name       = "";
	String run_name        = "";
	String prepay_fee      = "";
	String current_point   = "";
	String contract_no     = "";
	String vred_flag       = "";
	String vblack_flag     = "";
	String sm_name         = "";
	String grade_code	     = "";
	String region_code	   = "";
	String customer_credibility ="";
	
%>

<wtc:service name="sKFCustInfo_new" outnum="25" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" start="0" length="24" scope="end" />

<%
System.out.println("fcustMsg.jsp__retCode:"+retCode);
if("000000".equals(retCode)){
       if(result.length>0){
			cust_name       = result[0][0];
			id_name         = result[0][1];
			id_iccid        = result[0][2];
			contact_person  = result[0][3];
			contact_phone   = result[0][4];
			contact_address = result[0][5];
			contact_post    = result[0][6];
			linkman_name    = result[0][7];
			linkman_idiccid = result[0][8];
			assure_name     = result[0][9];
			assure_id       = result[0][10];
			vphone_no        = result[0][11];
			open_time       = result[0][12];
			sm_code         = result[0][13];
			card_name       = result[0][14];
			product_name    = result[0][15];
			town_name       = result[0][16];
			run_name        = result[0][17];
			prepay_fee      = result[0][18];
			current_point   = result[0][19];
			contract_no     = result[0][20];
			vred_flag       = result[0][21];
			vblack_flag     = result[0][22];
			sm_name		   = result[0][23];	

           }
     
%>
<wtc:array id="result1l" start="23" length="1" scope="end" />
<%

customer_credibility = result1l[1][0];
}
%>
<wtc:array id="result1" start="24" length="1" scope="end" />
<%
String kim_phone = new String();
if(retCode.equals("000000")){
       if(result1.length>0){          
	       	for(int i=0;i<result1.length;i++){
	       	   if(result1[i][0]!=null){
	       	    	kim_phone = kim_phone+result1[i][0]+"|";
	       	   }else{
	       	   		kim_phone="��";
	       	   }
	       	}
	       	      
       }  
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�û���ҳ</title>
		 <script type="text/javascript" src="../../../njs/extend/jquery/portalet/jquery114_pack.js"></script>
		 <script type="text/javascript" src="../../../njs/extend/jquery/portalet/interface_pack.js"></script>
		 <script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
	   <script language="JavaScript" src="/njs/si/validate_pack.js"></script>
		 <script type="text/javascript" src="/njs/extend/jquery/jquery.form.js"></script>
		 <script language="javascript" type="text/javascript" src="/njs/si/autocomplete.js"></script>
	   <script language="javascript" type="text/javascript" src="/njs/si/common.js"></script>
		 <link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
		 <link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
<%@ include file="/npage/include/public_hotkey.jsp" %>
<style>
	html,
	body,
	iframe
	{
		_overflow-x:hidden;
	}
	
	.ctl{
	   table-layout:fixed
	}
	.ctl td{text-overflow:ellipsis;overflow:hidden;white-space:nowrap;padding:2px}
	
</style> 
</head>
<body>
<!--�����˵�-->
<div class="menu" id=floater onFocus=this.blur()>
<ul>
	<li class="white"><a href="#this">ѡ���������<!--[if IE 7]><!--></a><!--<![endif]-->
		<table>
			<tr>
				<td>
					 <ul>
					 	<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div14" >���Ѽ��</a></li>
					 	<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div5" >��Ʒ��Ϣ</a></li>
					 	<li><a><input class="set" type="checkbox" style='cursor:hand' id="div4" >������Ϣ</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div16" >Ͷ�߽���</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' id="div11" checked >��ͻ�������Ϣ</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' id="div15" >������������</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' id="div17" >Ͷ�����</a></li>										 							
						<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div1" >����ͨ</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' id="div13" checked >�ʻ���������</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' id="div12" >������Ϣ</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div9" >SP�˶���ѯ</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand'  id="div8" >Ӫ���</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand'  id="div10" >������Ϊ&IMEI��Ϣ</a></li>						
						<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div7" >��ҵ�񶩹���Ϣ</a></li>
						<li><a class="last"><input class="set" type="checkbox" style='cursor:hand' id="div2" >���ù���</a></li>
					</ul>
				</td>
			</tr>
		</table>
	<!--[if lte IE 6]></a><![endif]-->
	</li>
</ul>
</div>
<br>

<!--�̶������-->
<div class="Info">
   <div class="groupItem_no">
		 <div class="itemHeader">
		   <div id="zi">������Ϣ</div>
		   <DIV id="tu">
			   <DIV id="sub">
		     <DIV class="li"><img id="reload0" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
			  </DIV>
			</DIV>
		 </div>
     <div id="blueBG">
       <div  id="custDocMsg">
			 	 <div id="blueBG">
 <div id="Info_table">
 	<table border="0" cellpadding="0" cellspacing="6" width="100%" class="ctl">
  	<tr>
  	    <th width="10%" nowrap >������</th>
  	  	<td width="30%" nowrap><%=cust_name.trim()%></td>
  	  	<th width="10%" nowrap>������룺</th>
  	  	<td width="40%"  colspan="3"><%=vphone_no.trim()%> &nbsp;&nbsp;&nbsp; <a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fSimDetailInfo.jsp');"><span class='orange'>[SIM������]</span></a></td>
  	  	<!--fSimDetailInfo.jsp-->
  	</tr>
  	<tr>
  	    <th nowrap >֤�����ͣ�</th>
  	  	<td nowrap><%=id_name.trim()%></td>
  	  	<th nowrap>����ʱ�䣺</th>
  	  	<td colspan="3" nowrap><%=open_time.trim()%></td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >֤�����룺</th>
  	  	<td nowrap><%=id_iccid.trim()%></td>
  	  	<th nowrap>Ʒ�ƣ�</th>
  	  	<td colspan="3" nowrap><%=null == sm_name?"" : sm_name.trim()%></td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >��ϵ�ˣ�</th>
  	  	<td nowrap><%=contact_person.trim()%></td>
  	  	<th nowrap>����</th>
  	  	<td colspan="3" nowrap><%=card_name.trim()%></td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >��ϵ�绰��</th>
  	  	<td nowrap><%=contact_phone.trim()%></td>
  	  	<th nowrap>�ײͣ�</th>
  	  	<td colspan="3" nowrap><%=product_name.trim()%> &nbsp;&nbsp;&nbsp; <a href=javascript:parent.parent.L("2","1270","���ʷѱ��","../../../page/ProductChange/f1270_login.jsp","000")  ><span class='orange'>���ʷѱ��</span></a> &nbsp;&nbsp;&nbsp; <a href=javascript:parent.parent.L("2","7135","��ҵ����","../../../page/ProductChange/f7135_login.jsp","000")  ><span class='orange'>��ҵ����</span></a></td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >��ַ��</th>
  	  	<td nowrap><%=contact_address.trim()%></td>
  	  	<th nowrap>����Ӫҵ����</th>
  	  	<td colspan="3" nowrap><%=town_name.trim()%>&nbsp;&nbsp;&nbsp; <a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/allbigpage.jsp?id=fgetEvInfo');"><span class='orange'>[��ҵ�񶩹���Ϣ]</span></a>&nbsp;&nbsp;&nbsp;</td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >�ʱࣺ</th>
  	  	<td nowrap><%=contact_post.trim()%></td>
  	  	<th nowrap>״̬��</th>
  	  	<td colspan="3" nowrap><span class="green"><%=run_name.trim()%></span>&nbsp;&nbsp;&nbsp; <%if(!run_name.trim().equals("����")) out.print("<img src='../../../nresources/default/images/shine.gif'><span class='orange'>�����ѿ�ͨ��</span>");  %>
			    <a href=javascript:parent.parent.L("2","1213","�ۺϱ��","PersonChange/s1213/f1213.jsp","000")  ><span class='orange'>�ۺϱ��</span></a>&nbsp;&nbsp;&nbsp; <a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fOperHistoryInfo.jsp');"><span class='orange'>[��ʷ��Ϣ]</span></a>
			    </td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >�����ˣ�</th>
  	  	<td nowrap><%=linkman_name.trim()%></td>
  	  	<th nowrap>�ʻ���</th>
  	  	<td colspan="3">
  	  		<span class="green"><%=Double.parseDouble(prepay_fee.trim())*-1%></span>&nbsp;&nbsp;&nbsp;<%if((Double.parseDouble(prepay_fee.trim())*-1)<10) out.print("<img src='../../../nresources/default/images/shine.gif' ><span class='orange'>�����ѿ�ͨ��</span>");  %> &nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp; <a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fPayHistoryInfo.jsp');"><span class='orange'>[�ɷѲ�ѯ]</span></a>&nbsp;&nbsp;&nbsp;
					<a href=javascript:parent.parent.L("2","1351","�ʵ���ʷ��ѯ","../page/PayManage/s1351/f1351.jsp?phoneNo=<%=phone_no%>","000")  ><span class='orange'>�ʵ���ʷ��ѯ</span></a>
				</td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >������֤����</th>
  	  	<td nowrap><%=linkman_idiccid.trim()%></td>
  	  	<th nowrap>���֣�</th>
  	  	<td colspan="3" nowrap><span class="green"><%=current_point.trim()%></span>
  	    <%if(Float.parseFloat(current_point)>100)out.print("<img src='../../../nresources/default/images/shine.gif' ><span class='orange'>���������ѣ�</span>");  %> &nbsp;&nbsp;&nbsp;
  	    
  	    <a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fKFPointDetail.jsp');"><span class='orange'>������ϸ��ѯ</span></a>
  	    </td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >������������</th>
  	  	<td nowrap><%=assure_name.trim()%></td>
  	  	<th nowrap>��ͬ�ţ�</th>
  	  	<td colspan="3" nowrap><%=contract_no.trim()%>&nbsp;&nbsp;&nbsp;
			    <a href=javascript:parent.parent.L("2","1515","��ѷ�������ѯ","MessageQuery/s1515/f1515_1.jsp","000")><span class='orange'>��ѷ�������ѯ</span></a></td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >������֤����</th>
  	  	<td nowrap><%=assure_id.trim()%></td>
  	  	<th nowrap>��������</th>
  	  	<td colspan="3" nowrap><%=vred_flag.trim()%></td>
  	   	
  	</tr>
  	<tr>
  	    <th nowrap >��������</th>
  	  	<td nowrap><%=vblack_flag.trim()%></td>
  	  	<th nowrap>������룺</th>
  	  	<td colspan="3" title="<%=kim_phone.trim()%>" nowrap>
  	  		<% 
  	  		// xingzhan 20090220 16:10 ��������Ϊ��������ģʽ
  	  				if(kim_phone==null||"".equals(kim_phone.trim())){
  	  		%>
  	  		��
  	  		<%						
  	  				}else{
  	  		%>
  	  		<a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fOperKim_PhoneInfo.jsp?kim_phone=<%=kim_phone.trim()%>&vphone_no=<%=vphone_no.trim()%>');"><span class='orange'>[�������]</span></a>
  	  		<%
  	  				}
  	  		//////////////////////////		
  	  		%>
  	  	</td>
  	</tr>
  
	<tr>
  	    
  	  	<th nowrap>�û������ȣ�</th>
  	  	<td  title="<%=customer_credibility%>" nowrap>
  	  	<%=customer_credibility%>
  	  	</td>	
  	</tr>

</table>
</div>
</div>
			 </div>
	   </div>
   </div>
</div>

<!--�����-->
<div id="sort1" class="groupWrapper">
	
	<div id="div5_show" class="groupItem">
			<div class="itemHeader">
			<div id="zi">��Ʒ��Ϣ</div>
			<DIV id="tu">
			   <div id="sub">  
			     
			     <DIV class="li"><img id="reload5" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
					 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
					 <div class="li"><img id="fproduct_sel" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
					 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"   style='cursor:hand' width="15" height="15"></div>				
					
					</div>
				</DIV>
		</div>
		
		<div class="itemContent" style="display:none"  id="product">
		
		     <div id="wait5"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
		     
		</div>
  </div>
  
 <div id="div4_show" class="groupItem">
		<div class="itemHeader">
			<div id="zi">������Ϣ</div>
			<DIV id="tu">
			   <div id="sub"> 	
			   <DIV class="li"><img id="reload4" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="fsource_sel" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   title="�ر�"  style='cursor:hand' width="15" height="15"></div>
			   </div>
			</DIV>
			</div>
			<div class="itemContent"  style="display:none"  id="source">
			   <div id="wait4"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
			</div>
	</div>
	
	
<div id="div9_show" class="groupItem" >
    
    <div class="itemHeader">
			<div id="zi">SP�˶���ѯ</div>
			<DIV id="tu">
			   <div id="sub"> 	
			   <DIV class="li"><img id="reload9" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="fspInfo" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>			 
			   </div>
			</DIV>
			</div>
			<div class="itemContent" style="display:none"  id="spInfo">
	       <div id="wait9" ><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			</div>
</div>

<div id="div17_show" class="groupItem">
	<div class="itemHeader">
			<div id="zi">Ͷ�����</div>
			<DIV id="tu">
			   <div id="sub"> 
				 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="fcomplainInfo" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"    title="�ر�"  style='cursor:hand' width="15" height="15"></div>		  
			   </div>
			</DIV>
	</div>
	  <div class="itemContent"style="display:none"  id="complainInfo">
		  <div id="wait17"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
		</div>
	</div>
	
<div id="div11_show" class="groupItem">
    <div class="itemHeader">
			<div id="zi">��ͻ�������Ϣ</div>
			<DIV id="tu">
			   <div id="sub"> 
			   <DIV class="li"><img id="reload11" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="fbigQuery" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>
			
			   </div>
			</DIV>
			</div>
			<div class="itemContent" style="display:none"  id="bigQuery">
	       <div id="wait11"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			</div>
	</div>
	
	
  
 <div id="div14_show" class="groupItem" >
    <div class="itemHeader">
				<div id="zi">���Ѽ��</div>
				<DIV id="tu">
				   <div id="sub">
				   	 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
						 <div class="li"><img id="fKF_AllFee" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
						 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>
						
				   </div>
				</DIV>
			</div>
			<div class="itemContent" style="display:none"  id="KF_AllFee">
	       <div id="wait14"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			</div>
	</div>
	
	
	 <div id="div10_show" class="groupItem">
		<div class="itemHeader">
			<div id="zi">������Ϊ&IMEI��Ϣ</div>
			<DIV id="tu">
			   <div id="sub"> 	
			   <DIV class="li"><img id="reload10" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="faccuGetImei" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   title="�ر�"  style='cursor:hand' width="15" height="15"></div>
			  
			   </div>
			</DIV>
			</div>
			<div class="itemContent" style="display:none"  id="accuGetImei">
			   <div id="wait10"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
			</div>
	</div>
	
		<div id="div2_show" class="groupItem">
			<div class="itemHeader">
				<div id="zi">���ù���</div>
					<DIV id="tu">
					   <div id="sub"> 
							 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���" style='cursor:hand' width="15" height="15"></div>
							 <div class="li"><img id="ffunc_sel" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
							 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif" title="�ر�"   style='cursor:hand' width="15" height="15"></div>
					  
					  </div>
					</DIV>
				</div>
			<div class="itemContent"  style="display:none"  id="funSel">
			   <div id="wait3"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
		  </div>
	  </div>

		</div>
</div>

<div id="sort2" class="groupWrapper">
	
	<div id="div13_show" class="groupItem">
	
	<div class="itemHeader">
			<div id="zi">�ʻ���������</div>
			<DIV id="tu">
			   <div id="sub">
			   	<DIV class="li"><img id="reload13" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 	<div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���" style='cursor:hand' width="15" height="15"></div>
				 	<div class="li"><img id="fKFConInfo" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 	<div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   title="�ر�" style='cursor:hand' width="15" height="15"></div>		  	
			   </div>
			</DIV>
			</div>
			<div class="itemContent" style="display:none"  id="KFConInfo">
			   <div id="wait13"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
			</div>
	  
		
	</div>
	
  <div id="div1_show" class="groupItem">
			<div class="itemHeader">
				<div id="zi">����ͨ</div>
				<DIV id="tu">
				   <div id="sub"> 
				   	 <DIV class="li"><img id="reload1" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
						 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
						 <div class="li"><img id="fserviceMsg" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
						 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>
				  		
				   </div>
				</DIV>
			</div>
			<div class="itemContent"style="display:none"  id="serviceMsg">
				<div id="wait2"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			</div>
      </div>
      
  <div id="div15_show" class="groupItem">
			<div class="itemHeader">
				<div id="zi">������������</div>
				<DIV id="tu">
				   <div id="sub"> 
						 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
						 <div class="li"><img id="fKFOrgInfo" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
						 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>
				  		
				   </div>
				</DIV>
			</div>
			<div class="itemContent"style="display:none"  id="KFOrgInfo">
				 <div id="wait15"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
      </div>
	  </div>
	  
	<div id="div7_show" class="groupItem">
	  <div class="itemHeader">
			<div id="zi">��ҵ�񶩹���Ϣ</div>
			<DIV id="tu">
			   <div id="sub"> 	
			   <DIV class="li"><img id="reload7" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���" style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="fgetEvInfo" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   title="�ر�" style='cursor:hand' width="15" height="15"></div>
			  
			   </div>
			</DIV>
			</div>
			<div class="itemContent" style="display:none"  id="accuGetEvInfo">
			   <div id="wait7"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
			</div>
	  </div>
	  
 <div id="div12_show" class="groupItem">
		<div class="itemHeader">
			<div id="zi">������Ϣ</div>
			<DIV id="tu">
			   <div id="sub"> 
			   <DIV class="li"><img id="reload12" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="fPayInfo" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   title="�ر�"  style='cursor:hand' width="15" height="15"></div>
			   
			   </div>
			</DIV>
			</div>
			<div class="itemContent" style="display:none"  id="PayInfo">
			   <div id="wait12"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
			</div>
	</div>
	
 <div id="div8_show" class="groupItem">
		<div class="itemHeader">
			<div id="zi">Ӫ���</div>
			<DIV id="tu">
			   <div id="sub">
			   	 <DIV class="li"><img id="reload8" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
					 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
					 <div class="li"><img id="faccuSellCust" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
					 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   title="�ر�"  style='cursor:hand' width="15" height="15"></div>
				
				</div>
				</DIV>
		</div>
		<div class="itemContent" style="display:none"  id="accuSellCust">
		     <div id="wait5"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
		</div>
	</div>

<div id="div16_show" class="groupItem">
    <div class="itemHeader">
				<div id="zi">Ͷ�߽���</div>
				<DIV id="tu">
				   <div id="sub"> 
						 <div class="li"><img class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
						 <div class="li"><img id="fcomAdvice" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
						 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>				  
				   </div>
				</DIV>
			</div>
			<div class="itemContent"style="display:none"  id="comAdvice">
				<div id="wait16"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
      </div>
		
	</div>
	
	</div>	
<p></p>


<script type="text/javascript">

var loadHash = new Object();
	
var reload0 = function(e)
{
	$("#custDocMsg").load("fcustMsg.jsp",false);
};
var reload1 = function(e)
{
	$("#serviceMsg").load("fserviceMsg.jsp",false);
};
var reload4 = function(e)
{
	$("#source").load("fsource_sel.jsp",false);
};

var reload5 = function(e)
{
	$("#product").load("fproduct_sel.jsp",false);
};

var reload7 = function(e)
{
	$("#accuGetEvInfo").load("fgetEvInfo.jsp",false);
};

var reload8 = function(e)
{
	$("#accuSellCust").load("faccuSellCust.jsp",false);
};

var reload9 = function(e)
{
	$("#spInfo").load("fspInfo.jsp",false);
}

var reload10 = function(e)
{
	$("#accuGetImei").load("faccuGetImei.jsp",false);
};

var reload11 = function(e)
{
	$("#bigQuery").load("fbigQuery.jsp",false);
};

var reload12 = function(e)
{
	$("#PayInfo").load("fPayInfo.jsp",false);
};


var reload13 = function(e)
{
	$("#KFConInfo").load("fKFConInfo.jsp",false);
};

var reload14 = function(e)
{
	$("#KF_AllFee").load("fKF_AllFee.jsp",false);
};
var reload15 = function(e)
{
	$("#KFOrgInfo").load("fKFOrgInfo.jsp",false);
};
var reload16 = function(e)
{
	$("#comAdvice").load("fcomAdvice.jsp",false);
};

var reload17 = function(e)
{
	$("#complainInfo").load("fcomplainInfo.jsp",false);
};




$(document).ready(function (){

loadHash["#serviceMsg"] = "fserviceMsg.jsp";
loadHash["#funSel"] = "ffunc_sel.jsp";
loadHash["#source"] = "fsource_sel.jsp";
loadHash["#product"] = "fproduct_sel.jsp";
loadHash["#accuGetEvInfo"] = "fgetEvInfo.jsp";
loadHash["#accuSellCust"] = "faccuSellCust.jsp";
loadHash["#accuGetImei"] = "faccuGetImei.jsp";
loadHash["#bigQuery"] = "fbigQuery.jsp";
loadHash["#KFConInfo"] = "fKFConInfo.jsp";
loadHash["#KF_AllFee"] = "fKF_AllFee.jsp";
loadHash["#PayInfo"] = "fPayInfo.jsp";
loadHash["#comAdvice"] = "fcomAdvice.jsp";
loadHash["#complainInfo"] = "fcomplainInfo.jsp";
loadHash["#KFOrgInfo"] = "fKFOrgInfo.jsp";
loadHash["#spInfo"] = "fspInfo.jsp";
//by zwy
loadHash["#div1_show"] = "serviceMsg";
loadHash["#div2_show"] = "funSel";
loadHash["#div4_show"] = "source";
loadHash["#div5_show"] = "product";
loadHash["#accuGetEvInfo"] = "accuGetEvInfo";
loadHash["#div7_show"] = "accuSellCust";
loadHash["#div10_show"] = "accuGetImei";
loadHash["#div11_show"] = "bigQuery";
loadHash["#div13_show"] = "KFConInfo";
loadHash["#div14_show"] = "KF_AllFee";
loadHash["#div12_show"] = "PayInfo";
loadHash["#div16_show"] = "comAdvice";
loadHash["#div17_show"] = "complainInfo";
loadHash["#div15_show"] = "KFOrgInfo";
loadHash["#div9_show"] = "spInfo";
		
		$('.set').bind('click',hiden);

		$("#reload0").bind('click',reload0);
		$("#reload1").bind('click',reload1);
		$("#reload4").bind('click',reload4);
		$("#reload5").bind('click',reload5);
		$("#reload7").bind('click',reload7);
		$("#reload8").bind('click',reload8);
		$("#reload10").bind('click',reload10);
		$("#reload11").bind('click',reload11);
		$("#reload12").bind('click',reload12);
		$("#reload13").bind('click',reload13);
		$("#reload14").bind('click',reload14);
		$("#reload15").bind('click',reload14);
		$("#reload16").bind('click',reload16);
		$("#reload17").bind('click',reload17);
		
		$('img.closeEl').bind('click', toggleContent);

		$('img.hideEl').bind('click', hideContent);
		/*
		$('div.groupWrapper').Sortable(
			{
				accept: 'groupItem',
				helperclass: 'sortHelper',
				activeclass : 	'sortableactive',
				hoverclass : 	'sortablehover',
				handle: 'div.itemHeader',
				opacity: 0.7,
				tolerance: 'intersect',
				onChange : function(ser)
				{
					dragLocation();
				},
				onStart : function()
				{
					$.iAutoscroller.start(this, document.getElementsByTagName('body'));
				},
				onStop : function()
				{
					$.iAutoscroller.stop();
				}
			}
		);
			
		*/	
/*
 *����ʼ��
 */
			$('.set').each(function(index)	{
		     
		     var did = "#"+this.id+"_show";
		     if(this.checked){
		     	 // hiddenContent(this.id+"_show");//by zwy ,20090506 ���۵�����
		       // $(did).show();
		     }else{
		     	  $(did).hide();
	       }
		});		
		
		//by zwy 20090506 �����ݼ��ص�ʱ���ܵȵ������ʱ���ټ��ء�
		//initLoad();	
	});
	
	
function initLoad()
{
				$('DIV.itemContent').each(function(index)	{
        if(($("#"+this.parentNode.id).attr('style')!="display:none")&&($("#"+this.parentNode.id).attr('style')!="DISPLAY: none"))
        {
           if(loadHash["#"+this.id]!=undefined){
            $("#"+this.id).load(loadHash["#"+this.id],false);
           }
         }
		});		
}	
var hiden = function()
{
	//��ѡ��
	var did = "#"+this.id+"_show";
	hiddenContent(this.id+"_show");
	if(this.checked)
	{
		$(did).show();
			$('DIV.itemContent').each(function(index)	{
       if(("#"+this.parentNode.id)==did)
       {
           if(loadHash["#"+this.id]!=undefined){
            $("#"+this.id).load(loadHash["#"+this.id],false);
           }
       }
     });	
	}
	else
		$(did).hide();
			
};


function hiddenContent(id)
{
 
		$('img.closeEl').each(function(index)	{
			var div_id = $(this.parentNode.parentNode.parentNode.parentNode.parentNode).attr('id');
			var targetContent = $('DIV.itemContent', this.parentNode.parentNode.parentNode.parentNode.parentNode);
			targetContent.slideUp(10);
			$(this).attr({ src: "../../../nresources/default/images/jia.gif"}); 
			
			if(id==div_id)
			{
		    targetContent.slideDown(100);
		    $(this).attr({ src: "../../../nresources/default/images/jian.gif"}); 
			}
		});	
}

var hideContent = function(e)
{
	var targetContent = $(this.parentNode.parentNode.parentNode.parentNode.parentNode);
	targetContent.hide();
	
	var div_id = $(this.parentNode.parentNode.parentNode.parentNode.parentNode).attr('id');
	
	if(div_id=="div1_show")
	{
		$("#div1").attr({checked:false});
	}else if(div_id=="div2_show")
	{
		$("#div2").attr({checked:false});
	}else if(div_id=="div3_show")
	{
		$("#div3").attr({checked:false});
	}else if(div_id=="div4_show")
	{
		$("#div4").attr({checked:false});
	}else if(div_id=="div5_show")
	{
		$("#div5").attr({checked:false});
	}else if(div_id=="div6_show")
	{
		$("#div6").attr({checked:false});
	}else if(div_id=="div7_show")
	{
		$("#div7").attr({checked:false});
	}else if(div_id=="div8_show")
	{
		$("#div8").attr({checked:false});
	}
	else if(div_id=="div9_show")
	{
		$("#div9").attr({checked:false});
	}
	else if(div_id=="div10_show")
	{
		$("#div10").attr({checked:false});
	}
		else if(div_id=="div11_show")
	{
		$("#div11").attr({checked:false});
	}
	else if(div_id=="div12_show")
	{
		$("#div12").attr({checked:false});
	}
	else if(div_id=="div13_show")
	{
		$("#div13").attr({checked:false});
	}
	else if(div_id=="div14_show")
	{
		$("#div14").attr({checked:false});
	}
		else if(div_id=="div15_show")
	{
		$("#div15").attr({checked:false});
	}
		else if(div_id=="div16_show")
	{
		$("#div16").attr({checked:false});
	}
			else if(div_id=="div17_show")
	{
		$("#div17").attr({checked:false});
	}

	
};

var toggleContent = function(e)
{
	var targetContent = $('div.itemContent', this.parentNode.parentNode.parentNode.parentNode.parentNode);
	if (targetContent.css('display') == 'none') {
		targetContent.slideDown(300);
		$(this).attr({ src: "../../../nresources/default/images/jian.gif"}); 
		//by zwy 20090506
		//alert(this.parentNode.parentNode.parentNode.parentNode.parentNode.id);
		var divid=this.parentNode.parentNode.parentNode.parentNode.parentNode.id;
		//alert(divid);
		//alert(loadHash["#"+divid]);
		//alert(loadHash["#"+loadHash["#"+divid]])
		if(loadHash["#"+loadHash["#"+divid]]!=undefined){
            $("#"+loadHash["#"+divid]).load(loadHash["#"+loadHash["#"+divid]],false);
    }
	} else {
		targetContent.slideUp(300);
		$(this).attr({ src: "../../../nresources/default/images/jia.gif"}); 
	}
	return false;
};

 // $("#custDocMsg").load("fcustMsg.jsp",false);

function showPageInfo(tagUrl)
{
	// xingzhan 20090220 ; ��Ϊ���Ը��Ĵ��ڴ�С;
	window.open(tagUrl,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
}

	/*
	*���λ��
	*/
	
	function dragLocation()
	{
		var dragId_1=document.getElementById("sort1");
		for(var i=0;i<dragId_1.childNodes.length;i++)
		{
			//alert("��һ��"+dragId_1.childNodes[i].id+"λ��"+i);
		}
		var dragId_2=document.getElementById("sort2");
		for(var j=0;j<dragId_2.childNodes.length;j++)
		{
			//alert("�ڶ���"+dragId_2.childNodes[j].id+"λ��"+j);
		}
	}  

	//by xingzhan 20090225 �����󴰿ڣ���Ϣ��ͬһ���󴰿�����ʾ
	var big_Opener;
	function openBigPage(value){
		
		var big_Url = "allbigpage.jsp";
		var id = value.id;
		//alert(id);
		//alert(big_Opener);
		if(big_Opener==null){
				//alert("1");
				
				big_Opener = window.open(big_Url+"?id="+id,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
		}else{
				//alert("2");
				try{
						big_Opener.document.body.focus();
						//alert("3");
						big_Opener.location.href(big_Url+"?id="+id);
			  }catch(e){
			  		//alert("4");
			  		big_Opener = window.open(big_Url+"?id="+id,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
			  }
				
		}
	}

</script>
</body>
</html>
