<%
   /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: piaoyi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String org_code = (String)session.getAttribute("orgCode");  
  String regionCode=org_code.substring(0,2);
  String sPONumber = request.getParameter("sPONumber"); 
  String cust_id="";
  int i=0;
  String sql =" select "+
          " a.TASK_SEQ,"+                  //0                                                       
          " a.PRODUCT_CODE,"+              //1
          " b.product_name as name,"+              //2
          " a.FAV_BEGIN,"+                 //3
          " a.SRV_NAME,"+                  //4
          " a.TASK_STATUS,"+               //5
          " a.EFFT_DATE,"+                 //6
          " a.PRODUCT_URL,"+               //7
          " a.OP_TIME,"+									 //8
          " a.TASK_NOTE,"+                 //9
          " decode(a.TASK_TYPE,'0','ȡ��','1','��ͨ') as task_type,"+//10
          " decode(a.TASK_STATUS,'1','����������','2','��������ɹ�','f','��������ʧ��','d','��������') as task_status,"+//11
          " decode(a.ORDER_OWE,'1','��','0','��') as order_owe,"+//12
          " c.function_name,"+						 //13
          " decode(nvl(d.open_way, '../../page/'),'1','',nvl(d.open_way, '../../page/'))|| c.form_name as open_way, "+								 //14
          " nvl(d.open_way,'0' ),"+         //15
          " a.TASK_TYPE,"+                   //16
          " decode(a.ORDER_BEFORE,'1','��','0','��') as order_before"+                   //17
          " from DMOTIVETASKINFO a,sproductcode b,sfunccodenew c,sFuncCodeAdd d"+
          " where a.PRODUCT_URL = c.function_code and c.function_code = d.function_code(+) and ORDER_SEQ = '?' and b.product_status = 'Y' and a.PRODUCT_CODE = b.PRODUCT_CODE";
   
  sql = sql+" union ";
    sql = sql +" select "+
        " a.TASK_SEQ,"+                  //0                                                       
        " a.PRODUCT_CODE,"+              //1
        " b.product_note as name,"+                  //2
        " a.FAV_BEGIN,"+                 //3
        " a.SRV_NAME,"+                  //4
        " a.TASK_STATUS,"+               //5
        " a.EFFT_DATE,"+                 //6
        " a.PRODUCT_URL,"+               //7
        " a.OP_TIME,"+									 //8
        " a.TASK_NOTE,"+                 //9
        " decode(a.TASK_TYPE,'0','ȡ��','1','��ͨ') as task_type,"+//10
        " decode(a.TASK_STATUS,'1','����������','2','��������ɹ�','f','��������ʧ��','d','��������') as task_status,"+//11
        " decode(a.ORDER_OWE,'1','��','0','��') as order_owe,"+//12
        " c.function_name,"+						   //13
        " decode(nvl(d.open_way, '../../page/'),'1','',nvl(d.open_way, '../../page/'))|| c.form_name as open_way,"+								 //14
        " nvl(d.open_way,'0' ),"+          //15
        " a.TASK_TYPE,"+                   //16
        " decode(a.ORDER_BEFORE,'1','��','0','��') as order_before"+                   //17
        " from DMOTIVETASKINFO a,sbillspcode b,sfunccodenew c,sFuncCodeAdd d"+
        " where a.PRODUCT_URL = c.function_code and c.function_code = d.function_code(+) and ORDER_SEQ = '?' and a.PRODUCT_CODE = b.bizcodeadd";
        
  sql=sql+" union ";
  sql=sql+ " select "+   
  			" a.TASK_SEQ,"+                  //0                                                       
       " a.PRODUCT_CODE,"+              //1
       " b.sm_name as name,"+                  //2
       " a.FAV_BEGIN,"+                 //3
       " a.SRV_NAME,"+                  //4
       " a.TASK_STATUS,"+               //5
       " a.EFFT_DATE,"+                 //6
       " a.PRODUCT_URL,"+               //7
       " a.OP_TIME,"+									 //8
       " a.TASK_NOTE,"+                 //9
       " decode(a.TASK_TYPE,'0','ȡ��','1','��ͨ') as task_type,"+//10
       " decode(a.TASK_STATUS,'1','����������','2','��������ɹ�','f','��������ʧ��','d','��������') as task_status,"+//11
       " decode(a.ORDER_OWE,'1','��','0','��') as order_owe,"+//12
       " c.function_name,"+						   //13
       " decode(nvl(d.open_way, '../../page/'),'1','',nvl(d.open_way, '../../page/'))|| c.form_name as open_way,"+								 //14
       " nvl(d.open_way,'0' ),"+          //15
       " a.TASK_TYPE,"+                   //16
       " decode(a.ORDER_BEFORE,'1','��','0','��') as order_before"+                   //17
       " from DMOTIVETASKINFO a,ssmcode b,sfunccodenew c,sFuncCodeAdd d"+
       " where a.PRODUCT_URL = c.function_code and c.function_code = d.function_code(+) and ORDER_SEQ = '?' and a.PRODUCT_CODE = b.sm_code and b.region_code='?' ";   
  
   
   System.out.println("sql>>"+sql);
   
   String sql1="select cust_id from dmotiveorderinfo where order_seq='"+sPONumber+"' ";
   System.out.println("sql>>"+sql1);
%>

	<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="15%" nowrap>�������</th>
	        <th width="15%" nowrap>�Ӳ�Ʒ����</th>
	        <th width="15%" nowrap>�Ӳ�Ʒ����</th>
	        <th width="15%" nowrap>�Ӳ�Ʒ��ǰ����</th>
	        <th width="15%" nowrap>��������</th>
	        <th width="15%" nowrap>����״̬</th>
	        <th width="15%" nowrap>����</th>
	      </tr>       	        	        	        	        	        	        	        	          
<tbody>
	

<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sql1%>
  </wtc:sql>		
</wtc:pubselect>
<wtc:array id="result1" length="1" scope="end" />
<%    
	if(retCode.equals("000000")){				   
		if(result1.length>0){
				cust_id=result1[0][0];
				System.out.println("cust_id="+cust_id);
			}
		}
%>
	

<wtc:service name="s7422Qry" outnum="20" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sPONumber%>"/>
	<wtc:param value="<%=regionCode%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="18" scope="end" />
<%    
	   retCode="999999";
	   retMsg="ϵͳ����";
	   System.out.println("result.length="+result.length);
	   
	   
		if(result.length>0){
			
	  	 for ( i=0;i<result.length;i++)
	  	 {
	  	  System.out.println("result[0]="+result[i][0]);
	  	  System.out.println("result[1]="+result[i][1]);
	  	  System.out.println("result[2]="+result[i][2]);
	  	
			
%>

	<tr a_TASK_SEQ=<%=result[i][0]%>
  					a_PRODUCT_CODE=<%=result[i][1]%>
  					a_product_name=<%=result[i][2]%>
  					a_FAV_BEGIN=<%=result[i][3]%>
  					a_SRV_NAME=<%=result[i][4]%>
  					a_TASK_STATUS=<%=result[i][5]%>
  					a_EFFT_DATE=<%=result[i][6]%>
  					a_OP_TIME=<%=result[i][8]%>
  					a_TASK_NOTE=<%=result[i][9]%> 
  					a_TASK_TYPE=<%=result[i][10]%>
  					a_TASK_STATUS_NAME=<%=result[i][11]%>
  					a_FuctionCode=<%=result[i][7]%> 
  					a_FuctionName=<%=result[i][13]%>
  					a_FuctionUrl=<%=result[i][14]%>
  					a_FuctionType=<%=result[i][15]%>
  					a_TASK_TYPE_CODE=<%=result[i][16]%>
  					a_ORDER_BEFORE=<%=result[i][17]%>
  			>
				  <td class="p_TASK_SEQ"><%=result[i][0]%>
				  </td>
				  <td class="p_PRODUCT_CODE"><%=result[i][1]%>				  	
				  </td>
				  <td class="p_product_name"><%=result[i][2]%>				  	
				  </td>
				  <td class="p_ORDER_BEFORE"><%=result[i][17]%>				  	
				  </td>
				  <td class="a_TASK_TYPE"><%=result[i][10]%>			  	
				  </td>			  
				  <td class="p_TASK_STATUS_NAME"><%=result[i][11]%>			  	
				  </td>
				  <td>
				  	<b>				  						  						  		
				  		<a class="p_TASK_DEAL" style="cursor: hand;">
				  		<%if(result[i][5].equals("1")||result[i][5].equals("f")){%>
				  		��������
				  		<%}else{%>
				  		�����鿴
				  		<%}%>	
				  		</a>					  		
				  		</b>
				  </td>				  
	      </tr>  
<%
       }
     
    }
%>
	      </tbody>	           
		</form>
	</table>
</div>
<input type ="hidden" value="" id="p_Funccode">
<input type ="hidden" value="" id="p_Funcname">
<input type ="hidden" value="" id="p_Funcurl">
<input type ="hidden" value="" id="p_Functype">
<input type ="hidden" value="" id="p_TASK_STATUS_NAME">
<!--��������-->
<DIV id="layer2" style="display:none">
	<DIV id="layer2_handle"class="layer_handle">
		��������
	</DIV>
	<DIV class="layer_content" >
		<form id="layer2_form" method="post" action="">
			<table width=90% >			
	     <tr>
         <td>
         �������
         </td>
         <td id="s_TASK_SEQ">&nbsp;		     	
         </td>
        	<td>
         �Ӳ�Ʒ��������
         </td>
         <td>
				  [<a class="s_PRODUCT_URL" style="cursor: hand;"
				  onclick="goOperPage()"></a>]
         </td>
		 		</tr>
		 		<tr>
         	 <td>
           	�Ӳ�Ʒ����
           </td>
           <td id = "s_PRODUCT_CODE">&nbsp;					  
           </td>
         	<td>
           	�Ӳ�Ʒ����
           </td>
           <td id ="s_product_name">&nbsp;	          
           </td>
		 		</tr>
		 		
		 		<tr>
         	 <td>
           	�Ӳ�Ʒ��ǰ����
           </td>
           <td colspan="3" id = "s_ORDER_BEFORE">&nbsp;					  
           </td>
		 		</tr>		 		
		 		
		 		<tr>
         	<td>
           	�Ż���Ϣ
           </td>
           <td id="s_SRV_NAME">&nbsp;				  
           </td>		 			
         	<td>
           	�Żݿ�ʼ����
           </td>
           <td id="s_FAV_BEGIN">&nbsp;					  
           </td>
        </tr> 		
		 		
		 		<tr>
         	 <td>
           	��������
           </td>
           <td id="s_TASK_TYPE">
           </td>
           <input type="hidden" id="s_TASK_TYPE_CODE">		
         	 <td>
           	������ֹ����
           </td>
           <td id="s_EFFT_DATE">	          
           </td>
         </tr>
        <tr>            	 			
         	 <td>
           	������ע
           </td>
           <td colspan="3">	
           	<input type="text" id="s_TASK_NOTE" size="60">				  
           </td>
		 		</tr>
		 		
		 		<tr>
         	<td>
           	����������
           </td>
           <td colspan="3">
					  <select id="s_TASK_OPER">
					  	<option value="2">�ɹ�</option>
					  	<option value="f">ʧ��</option>					  	
					  </select>
           </td>
		 		</tr>
				<tr>
					<td align=center colspan=4>
							<input class="b_foot" id=save2 type=button value="ȷ��">
							<input class="b_foot" id=close3 type=button value="�ر�">
					</td>
				</tr>
			</table>
		</form>
	</DIV>
</DIV>         

<script>                                                                                       
$(document).ready(function(){
	  
    //���ع�����
    $("#wait2").hide();
    
		$('.p_TASK_DEAL').click(function(){
			$("#layer2").show();
      var ProductOrderTR = $(this).parent().parent().parent();
			$("#p_Funccode").val("");
			$("#p_Funcname").val("");
			$("#p_Funcurl").val("");
			$("#p_Functype").val("");
			$("#p_Funccode").val($(ProductOrderTR).attr("a_FuctionCode"));  
			$("#p_Funcname").val($(ProductOrderTR).attr("a_FuctionName"));
			$("#p_Funcurl").val($(ProductOrderTR).attr("a_FuctionUrl")); 
			$("#p_Functype").val($(ProductOrderTR).attr("a_FuctionType")); 			
			$(".s_PRODUCT_URL").text($(ProductOrderTR).attr("a_FuctionName"));
			$("#s_ORDER_BEFORE").text($(ProductOrderTR).attr("a_ORDER_BEFORE"));
      $("#s_TASK_SEQ").text($(ProductOrderTR).attr("a_TASK_SEQ"));
      $("#s_PRODUCT_CODE").text($(ProductOrderTR).attr("a_PRODUCT_CODE"));
      $("#s_product_name").text($(ProductOrderTR).attr("a_product_name"));
      $("#s_FAV_BEGIN").text($(ProductOrderTR).attr("a_FAV_BEGIN"));
      $("#s_EFFT_DATE").text($(ProductOrderTR).attr("a_EFFT_DATE"));
      $("#s_PRODUCT_URL").text($(ProductOrderTR).attr("a_PRODUCT_URL"));      
      $("#s_TASK_NOTE").val("����<%=workNo%>�Զ���"+$(ProductOrderTR).attr("a_TASK_SEQ")+"����"+$(ProductOrderTR).attr("a_FuctionName")+"����");
      $("#s_SRV_NAME").text($(ProductOrderTR).attr("a_SRV_NAME"));
      $("#s_TASK_TYPE").text($(ProductOrderTR).attr("a_TASK_TYPE")); 
      //alert($(ProductOrderTR).attr("a_TASK_TYPE_CODE"));
      $("#s_TASK_TYPE_CODE").val($(ProductOrderTR).attr("a_TASK_TYPE_CODE"));
       $("#p_TASK_STATUS_NAME").val($(ProductOrderTR).attr("a_TASK_STATUS_NAME"));
       //alert($("#p_TASK_STATUS_NAME").val());
      if($(ProductOrderTR).attr("a_TASK_STATUS")=="1"||$(ProductOrderTR).attr("a_TASK_STATUS")=="f")
      {
      	  $("#save2").attr("disabled","");
      	  $("#layer2_handle").text("��������");
      		
      }else{
      	  $("#save2").attr("disabled","true");
      		$("#layer2_handle").text("�����鿴");
      }
		});
							
	  $('#close3').click(function(){
				$("#layer2").hide();
		});		
		
 		//��������ȷ��
		$('#save2').click(function(){
			$("#layer2").hide();
			var cfmpacket = new AJAXPacket("f7416_order_deal.jsp", "�����ύ,���Ժ�......");
			cfmpacket.data.add("sWorkNo", "<%=workNo%>");//��������
			cfmpacket.data.add("sPassWord", "<%=password%>");//��������
			cfmpacket.data.add("sOpCode", "7416");//���ܴ���
			cfmpacket.data.add("sPONumber", $("#p_PONumber").val());//�������
			cfmpacket.data.add("sUnitID", $("#p_CustID").val());//�ͻ�ID
			cfmpacket.data.add("sIDNo", $("#p_IDNo").val());//ҵ����û�ID
			cfmpacket.data.add("sTASK_SEQ", $("#s_TASK_SEQ").text());//�������
			cfmpacket.data.add("sTASK_TYPE_CODE", $("#s_TASK_TYPE_CODE").val());//��������
			cfmpacket.data.add("sTASK_OPER", $("#s_TASK_OPER").val());//����������
			cfmpacket.data.add("sTASK_NOTE", $("#s_TASK_NOTE").val());//ע��
			
			core.ajax.sendPacket(cfmpacket,OrderDealRtn,false);
			cfmpacket=null;
		});
});    
function goOperPage()
{
	if($("#p_TASK_STATUS_NAME").val()=="��������ɹ�")
	{
		rdShowMessageDialog("���������Ѿ�����ɹ��������ٴβ���!",1);
		return false;
	}
	if($("#p_TASK_STATUS_NAME").val()=="��������")
  {
  	rdShowMessageDialog("���������Ѿ������������ٴβ���!",1);
		return false;
  }
	if($("#s_ORDER_BEFORE").text()=="��")
	{
		rdShowMessageDialog("�ò�Ʒ��ǰ�Ѿ������������ٴο�������ֱ�Ӵ�����!",1);
		return false;
	}
	//alert($("#p_Funcurl").val());
	//alert($("#p_Funcurl").val()+"?cust_id="+<%=cust_id%>);
	var vurl=$("#p_Funcurl").val()+"?cust_id="+<%=cust_id%>;
	//alert(vurl);
	parent.openPage($("#p_Functype").val(),$("#p_Funccode").val(),$("#p_Funcname").val(),vurl,'');
}

		                                                                    	 
</script>
