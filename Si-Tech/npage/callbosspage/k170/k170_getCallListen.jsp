
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%	
			
      String opCode="K170";
      String opName="�ۺϲ�ѯ-������Ϣ-��ȡ����";
       /*midify by yinzx 20091113 ������ѯ�����滻*/
      String myParams="";
      String myParamsCount="";
      String org_code = (String)session.getAttribute("orgCode");
      String regionCode = org_code.substring(0,2);
	    String sqlStr = "";
	    int que_flag = 1;
	    String strContact_id=request.getParameter("flag_id")==null?"":request.getParameter("flag_id");
	    //¼���ֱ� by libin 2009-05-22
	    String  tablename_ym = "";
	    
	    if(!strContact_id.equals("") && strContact_id.length()>6){
	    	tablename_ym = strContact_id.substring(0,6);
	    }
	    
	   // strContact_id="111120081000000000000161";
	//    out.println(strContact_id);
	    String sSqlCondition="";
	    //��ҳ1
	    int rowCount=0;
	    int pageSize=10;            //ÿҳ����
	    int pageCount=0;              //�ܵ�ҳ��
	    int curPage=0;                //��ǰҳ
	    String strPage;             //��Ϊ������������ҳ	 
	    
      strPage = request.getParameter("page");
      String[][] dataRows = new String[][]{};
	    boolean bUserExist=false;
	
	    String action=request.getParameter("myaction");
  //��ѯ��ɫ
    if ("doLoad".equals(action)) {
        sqlStr = "select to_char(file_id),kf_file_id,login_no,contact_id,create_time,file_path from dcallrecordfile"+tablename_ym+" where 1=1 and contact_id=:strContact_id";
        myParams ="strContact_id="+strContact_id;
        que_flag = 2;
    }


    if(que_flag==1){
        //��ʼ�����ӽ���
        //��ҳ2
 					String  sql = "select to_char(count(*)) count from dcallrecordfile"+tablename_ym+" where 1=1 and contact_id=:vstrContact_id";                    
          myParamsCount="vstrContact_id="+strContact_id;
	        %>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sql%>"/>
						<wtc:param value="<%=myParamsCount%>"/>
					</wtc:service>
					<wtc:array id="rowsC"  scope="end"/>	
					<% 
        rowCount = Integer.parseInt(rowsC[0][0]);
        if (strPage==null||strPage.equals("")||strPage.trim().length()==0){
          curPage=1;
        }else{
            curPage=Integer.parseInt(strPage);
          if(curPage<1) curPage=1;
        }
        pageCount=(rowCount+pageSize-1)/pageSize;
        if (curPage>pageCount) curPage=pageCount;
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;     
        sqlStr = "select to_char(file_id),kf_file_id,login_no,contact_id,to_char(create_time,'yyyy-mm-dd hh24:mi:ss'),file_path from dcallrecordfile"+tablename_ym+" where 1=1 and contact_id=:strContact_id";
        myParams ="strContact_id="+strContact_id;
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        %>		

				<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="7">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList" start="0" length="6" scope="end"/>
				<%
				dataRows = queryList;
			
       }
	    else
	    {
        //�����ѯ����ҳ��ť����
        //��ҳ2'
        String  sql = PageFilterSQL.getCountSQL(sqlStr);
         %>	
         <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" >
					<wtc:param value="<%=sql%>"/>
					<wtc:param value="<%=myParams%>"/>
				  </wtc:service>
				 <wtc:array id="rowsC2" scope="end"/>
				<%					
        rowCount = Integer.parseInt(rowsC2[0][0]);
        if (strPage==null||strPage.equals("")||strPage.trim().length()==0){
          curPage=1;
        }else{
            curPage=Integer.parseInt(strPage);
          if(curPage<1) curPage=1;
        }
        pageCount=(rowCount+pageSize-1)/pageSize;
        if (curPage>pageCount) curPage=pageCount;
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        %>		
				<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="7" >
					<wtc:param value="<%=querySql%>"/>
					<wtc:param value="<%=myParams%>"/>
				</wtc:service>
				<wtc:array id="queryList2" start="0" length="6" scope="end"/>
				<%
				dataRows = queryList2;
      }
%>
<base target="_self">
<html>
<head>
<title>�ۺϲ�ѯ-������Ϣ-��ȡ����</title>
<script LANGUAGE=javascript>
$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	  
		function doLoad(operateCode){
    if(operateCode=="load")
    {
      document.sitechform.page.value="";
    }
    else if(operateCode=="first")
    {
      document.sitechform.page.value=1;
    }
    else if(operateCode=="pre")
    {
      document.sitechform.page.value=<%=(curPage-1)%>;
    }
    else if(operateCode=="next")
    {
      document.sitechform.page.value=<%=(curPage+1)%>;
    }
    else if(operateCode=="last")
    {
      document.sitechform.page.value="<%=pageCount%>";
    }
      document.sitechform.myaction.value="doLoad";
      document.sitechform.action="k170_getCallListen.jsp";
      document.sitechform.method='post';
      document.sitechform.submit();

 }
 
 
 
 
function doProcessNavcomring(packet)	 
	 {
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("����ɹ�!");
	    		window.close();
	    	}else{
	    		//alert("����ʧ��!");
	    		window.close();
	    		return false;
	    	}
	    }
	 } 
 
 function doLisenRecord(i)
 
{
		  var filepath=document.getElementById(i).value;
		   window.opener.top.document.getElementById("recordfile").value=filepath;
		   window.opener.top.document.getElementById("lisenContactId").value='<%=strContact_id%>';
		   window.opener.top.document.getElementById("K042").click();
			var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","���ڴ���,���Ժ�...");
	     packet.data.add("retType" ,  "chkExample");
	     packet.data.add("filepath" ,  filepath);
	     core.ajax.sendPacket(packet,doProcessNavcomring,true);
			 packet =null;

}
</SCRIPT>
</head>

<body >
  <form name="sitechform" method="post" >
  	<%@ include file="/npage/include/header_pop.jsp"%>
  	<div id="Operation_Table"  style="width: 100%;">
  	<div class="title"><div id="title_zi">�����б�</div></div>
  		<table cellspacing="0">

	      <tr>
	       <td>
		       <table  cellspacing="0" >
		          <tr >
		          	 <th align="center"   width="15%" >���</th>
		            <th  align="center"  width="15%" >��ˮ��</th>
		            <th  align="center"  width="15%"  >�ͷ���ˮ</th>
		            <th  align="center"  width="15%" >��ϯ����</th>
			          <th  align="center"  width="15%" >¼��ʱ��</th>
			           <th align="center"   width="25%" >�ļ�·��</th>
			        </tr>
		         <% for (int i=0;i<dataRows.length;i++) { 
		         String cdClass = "";
							%>
							<%if (i%2==0){
							cdClass = "grey";
							}
							%>
		
						 <tr  >
	            <td align="center"  class="<%=cdClass%>" >
	            	<%=i%>
							</td>
	            <td align="center"  class="<%=cdClass%>" > <a href="#" onclick="doLisenRecord('<%=i%>');"><%=dataRows[i][0]%></a>
	            </td>
	
	            <td align="center"  class="<%=cdClass%>" ><%=dataRows[i][3]%>&nbsp;</td>
	            <td align="center"  class="<%=cdClass%>" ><%=dataRows[i][2]%>&nbsp;</td>
	
	            <td align="center"  class="<%=cdClass%>" ><%=dataRows[i][4]%>&nbsp;</td>
	            <td align="center"  class="<%=cdClass%>" ><%=dataRows[i][5]%>&nbsp;</td>
	             <input type="hidden"  id="<%=i%>" value="<%=dataRows[i][5]%>">&nbsp;  
	           </tr>
	           <% } %>
	        </table>
	      </td>
	    </tr>
   <tr>
	    	<td>
        <!--//��ҳ4-->
        <table cellspacing="0">
				<input type="hidden" id="page" name="page" value="">
				<input type="hidden" id="myaction"  name="myaction" value="">
    	  <tr >
            <td align="right" width="720">
              <%if(pageCount!=0){%>
              �� <%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
              <%} else{%>
              <font color="red">��ǰ��¼Ϊ�գ�</font>
              <%}%>
              <%if(pageCount!=1 && pageCount!=0){%>
              <a href="#"  onClick="doLoad('first');return false;">��ҳ</a>
              <%}%>
              <%if(curPage>1){%>
              <a href="#"   onClick="doLoad('pre');return false;">��һҳ</a>
              <%}%>
              <%if(curPage<pageCount){%>
              <a href="#"   onClick="doLoad('next');return false;">��һҳ</a>
              <%}%>
              <%if(pageCount>1){%>
              <a href="#"   onClick="doLoad('last');return false;">βҳ</a>
              <%}%>
            </td>
			    </tr>
			    <tr>
			    <td>
		 
        

			    </td>
			    <tr>
			  </table>
      </td>
    </tr>
  </table>
</div>
  <%@ include file="/npage/include/footer_pop.jsp"%>
   </form>
  </body>
</html>
