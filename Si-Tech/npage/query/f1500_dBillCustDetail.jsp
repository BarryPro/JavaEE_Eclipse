<%
/********************
 version v2.0
������: si-tech
	*
	*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
	*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = "1500";
  String opName = "��ϸ�Ż���Ϣ";
  String iChnSource = "01";
  String regionCode = (String)session.getAttribute("regCode");	
	String id_no= request.getParameter("idNo");
	String work_no=request.getParameter("workNo");
	String dNopass = (String)session.getAttribute("password");
	String work_name=request.getParameter("workName");
	String table_str=id_no.substring(id_no.length()-1,id_no.length());
	String phone_no = request.getParameter("phoneNo");
	String PrintAccept = getMaxAccept();
	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");

	/*
	String sql_str="select a.mode_code,b.mode_name,decode(a.mode_flag,'0','���ʷ�','1','����','2','��ѡ'),"
	+" decode(a.detail_type,'0','����','1','����','2','�ʵ��Ż�','3','ͨ�������Ż�','4','�ط��Ż�','a','�ط���' ), "
	+" trim(c.note),to_char(a.begin_time,'YYYYMMDD'),to_char(a.end_time,'YYYYMMDD'),"
	+" decode(a.mode_status,'Y','��ͨ','N','ȡ��'),a.fav_order,a.op_code,to_char(op_time,'YYYYMMDD HH24 MI SS'),a.login_no "
	+" from dBillCustDetail" + table_str + " a, sBillModeCode b, sBillModeDetail c "
	+" where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code=c.region_code and a.mode_time='Y' "
	+" and a.mode_code=c.mode_code and b.mode_code=c.mode_code and a.detail_type=c.detail_type and a.detail_code=c.detail_code "
	+" and a.id_no=" +id_no+ " order by substr(a.mode_code,3,1),to_char(a.begin_time,'YYYYMMDD')";
	*/
	/**
	String sql_str="SELECT   a.offer_id,b.offer_name,decode(b.offer_type,'10','���ʷ�','20','�ײ�����Ʒ','30','�������Ʒ','40','��ѡ�ײ�'), "
		+" to_char(a.eff_date,'YYYYMMDD'),to_char(a.exp_date,'YYYYMMDD'), "
		+" decode(sign(a.exp_date-sysdate),1,'��Ч',-1,'��ȡ��','�鵵'),a.priority,to_char(state_date,'YYYYMMDD HH24:MI:SS'),a.HANDLE_LOGIN_NO,b.offer_comments"
        +" FROM product_offer_instance a, product_offer b "
        +" WHERE a.offer_id = b.offer_id AND a.serv_id = " +id_no+ " "
		+" ORDER BY a.eff_date ";
        
	System.out.println("sql_str  :   " + sql_str);
	**/
%>

<wtc:service name="s1500_prodinst" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="19">
		<wtc:param value="<%=PrintAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=work_no%>" />
		<wtc:param value="<%=dNopass%>" />
		<wtc:param value="<%=phone_no%>" />
		<wtc:param value="" />
		<wtc:param value="<%=id_no%>" />
	</wtc:service>
	<wtc:array id="result11" start="0" length="3" scope="end"/>
	<wtc:array id="result22" start="3" length="16" scope="end"/>


<%
	int iretCode=999999; 
	System.out.println("gaopengSeeLog1500---result11.length==="+result11.length);
	System.out.println("gaopengSeeLog1500---result22.length==="+result22.length);
	System.out.println("gaopengSeeLog1500---retCode1==="+retCode1);
	System.out.println("gaopengSeeLog1500---retMsg1==="+retMsg1);
	if(retCode1!=null&&!"".equals(retCode1)){
		iretCode=Integer.parseInt(retCode1);
	}
	if(iretCode!=0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if (result11==null||result11.length==0){
%>
		<script language="JavaScript">
			rdShowMessageDialog("û�з�������������,��ϸ�Ż���ϢΪ��!");
			history.go(-1);
		</script>
<%	
	return;
	}
	
	//al = Wrapper.s1500_BillCust(work_no,phone_no,id_no);
%>
	<wtc:service name="s1500_dBillCust" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="7" >
	<wtc:param  value=""/>
  <wtc:param  value="01"/>
  <wtc:param  value="<%=opCode%>"/>
  <wtc:param  value="<%=work_no%>"/>
  <wtc:param  value="<%=password%>"/>
  <wtc:param  value="<%=phone_no%>"/>
  <wtc:param  value=""/>
	<wtc:param value="<%=id_no%>"/>
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end"/>
	<wtc:array id="result2" start="2" length="5" scope="end"/>
<%		
	int valid = 0;
	 
	if( result1==null||result1.length==0||result2==null){
		valid = 1;
	}else{
		if( !result1[0][0].equals("000000") ){
			valid = 2;
		}else{
			valid = 0;
		}
	}
	if( valid == 1){
%>
		<script language="JavaScript">
			rdShowMessageDialog("ϵͳ��������ϵͳ����Ա��ϵ��лл!!");
			history.go(-1);
		</script>	
<%
	}else if( valid == 2){
%>
		<script language="JavaScript">
			rdShowMessageDialog("ҵ�����<br>�������:<%=result11[0][0]%><br>������Ϣ:<%=result11[0][1]%>");
			history.go(-1);
		</script>
<%
	}else{
%>
<HEAD><TITLE>��ϸ�Ż���Ϣ</TITLE>

	<script language="javascript">
		function updateMsg(rowId){
			var msgArr = new Array();
			<%
				for(int i = 0; i < result22.length; i++){
			%>
					msgArr[<%=i%>] = "<%=result22[i][9]%>";
			<%
				}
			%>
			$("#msgDiv").children("span").text(msgArr[rowId]);
		}
		
		$(document).ready(function(){
			var msgNode = $("#msgDiv").css("border","1px solid #999").width("260px")
                            .css("position","absolute").css("z-index","99")
                            .css("background-color","#dff6b3").css("padding","8");
            msgNode.hide();
        	var as = $("a");
        	as.css("cursor","hand").css("font-weight","600");
        	as.mouseover(function(event){
        		//��ȡ��ǰ׼����ʾ������
	            var aNode = $(this);
	            aNode.css("color","#3366CC");
	            var divNode = aNode.parent();
	            sid = divNode.attr("rowId");
	            updateMsg(sid);
	            var myEvent = event || windows.event;
            	msgNode.css("left",myEvent.clientX + 8 + "px").css("top",myEvent.clientY + 8 + "px");
            	//��������ʾ
            	msgNode.show();
        	});
        	as.mouseout(function(){
        		var aNode = $(this);
	            aNode.css("font-weight","600").css("color","#333333");
            	msgNode.hide();
        	});
		});
	</script>
</HEAD>
<body>

<FORM method=post name="f1500_dBillCustDetail02">
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">��ϸ�Ż���Ϣ</div>
		</div>
	   <TABLE cellSpacing="0">
	     <TBODY>
	      <TR align="center">
	        <th>�Żݴ���</th>
	        <th>�Ż�����</th>
	        <th>�Ż�����1</th>
	        <th>��ʼʱ��</th>
	        <th>����ʱ��</th>                  
	        <th>״̬</th>
	        <th>�Ż�˳��</th>
	        <th>����ʱ��</th>                  
	        <th>��������</th>
	        <th>��������</th>
	        <th>�����Ƿ��ת</th>
	        <th>�������ȼ�</th>
	        <th>����ҵ�����ȼ�</th>
	      </TR>
<%	      
		System.out.println("����:  :   " + result11[0][2]);
		/*out.println("����:  :   " + result11[0][2]);
		out.println("����:  :   " + result11[0][0]);
		out.println("����:  :   " + result11[0][1]);
		out.println("����:  :   " + result22[0].length);
		*/
			for(int y=0;y<Integer.parseInt(result11[0][2]);y++){
			

%>
	    <tr align="center">
	    <%
	    	if(result22[y].length > 0){
	    		if(result22[y][5].trim().equals("��Ч"))
	    		{
	    %>
	    <td class="InputGrey">
	    	11-<div rowId="<%= y%>"><a><%= result22[y][0]%></a></div>
	    </td>
	    <td class="InputGrey">
	    	22-<div rowId="<%= y%>"><a><%= result22[y][1]	%></a></div>
	    </td>
	    <%
	    		}
	    	  else
	    	  {
	    	  
	    %>	
	    <td class="Grey">
	    	3<div rowId="<%= y%>"><a><%= result22[y][0]%></a></div>
	    </td>
	    <td class="Grey">
	    	4<div rowId="<%= y%>"><a><%= result22[y][1]%></a></div>
	    </td>
	    <%
	    		}  	
	    	}
	    %>
<%    	
				for(int j=2;j<result22[0].length ;j++)
				{	
				if(j==9) {
				 continue;
				}
				if(j==10) {
				System.out.println("�ʷ����ȼ�" + result22[y][j]);
				 continue;
				}				
				if(j==11) {
				 continue;
				}
				 	
					if(result22[y][5].trim().equals("��Ч"))
	    		{
%>
		  <td class="InputGrey">1a<%= result22[y][j]%>&nbsp;</td>
<%
					}
					else
					{
%>
		  <td class="Grey">b2<%= result22[y][j]%>&nbsp;</td>
<%		
					}		
					
					System.out.println("==========gaopengSeeLog1500====================result22["+y+"]["+j+"]" + result22[y][j]);		
				}
%>
	        </tr>
<%
	      }
        for (int i=0;i<result2.length;i++){%>
        
						<tr align="center">
						      <td>
                    <div align="center"><%=result2[i][0].trim()%></div>
                  </td>
                  <td>
                    <div align="center"><%=result2[i][1].trim()%></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                   <td>
                    <div align="center"><%=result2[i][2].trim()%></div>
                  </td>
                   <td>
                    <div align="center"><%=result2[i][3].trim()%></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                   <td>
                    <div align="center"><%=result2[i][4].trim()%></div>
                  </td>
			 					</tr>
		<%}%>
          </TBODY>
  		</TABLE>
      <font color="red">1.��GPRS�ʷ����ȼ�˵�������ʷ����ȼ��ȿ���һλ������Խ�����ȼ�Խ�ߣ����һλ��ͬȡ������͵����ۣ��������ͬ�ٿ��ڶ�λ��;<br>
      2.GPRS�ʷ����ȼ�˵������ֵԽС���ȼ�Խ�ߣ����ȼ���ͬʱȡ������͵�����;<br>3.ԤԼʧЧ��������ת�ʷ�ʧЧ���²���ת��</font>
      <table cellspacing=0>
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onclick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
      	<div id="msgDiv">
	        �ʷ�˵����<span></span>
	    </div>
		</FORM>
		</BODY>
		<%@ include file="/npage/include/footer.jsp" %>
	</HTML>
<%
}
%>
