<%
   /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%
     String workNo = (String)session.getAttribute("workNo");
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
		 String sCustomerProvinceNumber = request.getParameter("sCustomerProvinceNumber");
		 String sNeedOpButton = request.getParameter("sNeedOpButton");
		 String sp_Action= request.getParameter("sp_Action");
		 System.out.println("sNeedOpButton = "+sNeedOpButton);
		 System.out.println("sp_Action = "+sp_Action);
%>

<div id="form">
	<input type="hidden" id=p_Action value="<%=sp_Action%>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="10%" nowrap>选择</th>
	        <th width="25%" nowrap>姓名</th>
	        <th width="25%" nowrap>人员角色</th>
	        <th width="25%" nowrap>性别</th>
	        <th width="25%" nowrap>联系电话</th>
	      </tr>
        <tbody>
<wtc:service name="s9101DetQry" outnum="22" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0"/>
	<wtc:param value="<%=sCustomerProvinceNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="20" scope="end" />
<%
	if(retCode.equals("000000")){				   
		if(result.length>0){
			for(int i=0;i<result.length;i++){			  
%>
  			  <tr class="keyperson_contenttr"
  			  	  a_Role="<%=result[i][1]%>"
  			  	  a_PartyName="<%=result[i][2]%>"
  			  	  a_Sex="<%=result[i][3]%>"
  			  	  a_ContactPhone="<%=result[i][4]%>"
  			  	  a_Title="<%=result[i][5]%>"
  			  	  a_Alias="<%=result[i][6]%>"
  			  	  a_Birthday="<%=result[i][7]%>"
  			  	  a_Memorial="<%=result[i][8]%>"
  			  	  a_Mate="<%=result[i][9]%>"
  			  	  a_Secretary="<%=result[i][10]%>"
  			  	  a_School="<%=result[i][11]%>"
  			  	  a_ClassMates="<%=result[i][12]%>"
  			  	  a_Hobby="<%=result[i][13]%>"
  			  	  a_Leader="<%=result[i][14]%>"
  			  	  a_LeaderDept="<%=result[i][15]%>"
  			  	  a_Vassal="<%=result[i][16]%>"
  			  	  a_Intercourse="<%=result[i][17]%>"
  			  	  a_CustomerProvinceNumber="<%=result[i][0]%>"
  			  	  a_OperType="OLD"
  			  	>
						<td classes="grey"><input type="checkbox" name="KeyPersonListChkBox" value="0" >
					  </td>
				    <td><a class="p_PartyName" style="cursor: hand;"><%=result[i][2]%></a>
					  &nbsp</td>
					  <td class=p_Role><%=result[i][18]%>&nbsp					  	
					  </td>
					  <td class=p_Sex><%=result[i][19]%>&nbsp
					  </td>
					  <td class=p_ContactPhone><%=result[i][4]%>&nbsp
					  </td>
	        </tr>
<%
       }
     }
  }
%>

<%
if("1".equals(sNeedOpButton))
{
%>
	        <tr id="keyPerson_buttontr">

	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="KeyPersonAdd" value="新增">
	        		&nbsp;
	        		<input type="button" class="b_text" id="KeyPersonDel" value="删除">
	          </th>
	        </tr>
<%
}
%>
	      </tbody>
		</form>
	</table>
</div>
<script>


//隐藏滚动条
$("#wait2").hide();

$(document).ready(function(){
	
	

   //注册新增函数
	 $('#KeyPersonAdd').click(function(){
	     KeyPersonAdd();
	 });

	 //注册更新函数
	 $('.p_PartyName').bind('click', KeyPersonUpdate);

	 //注册删除函数
	 $('#KeyPersonDel').click(function(){
	     KeyPersonDel();
	 });

	 //新增函数
	 function KeyPersonAdd(){
	 	  var keyPerson = new Array(18);
	 	  keyPerson=[
	 	            "",                                  //0   人员角色
	 	            "",                                  //1   姓名
	 	            "",                                  //2   性别
	 	            "",                                  //3   联系电话
	 	            "",                                  //4   职务
	 	            "",                                  //5   昵称
	 	            "",                                  //6   生日
	 	            "",                                  //7   纪念日
	 	            "",                                  //8   配偶姓名
	 	            "",                                  //9   秘书姓名
	 	            "",                                  //10  毕业院校
	 	            "",                                  //11  同窗
	 	            "",                                  //12  兴趣、爱好
	 	            "",                                  //13  上级领导
	 	            "",                                  //14  上级部门
	 	            "",                                  //15  下级部门
	 	            "",                                  //16  社交圈
	 	            $("#p_CustomerProvinceNumber").val(), //17  集团归属省编码
	 	            $("#p_Action").val()                  //18  操作类型
	 	            ]
	    var retInfo = window.showModalDialog
	    (
	    'f2002_KeyPerson_detail.jsp?s_CustomerNumber='+$("#p_CustomerNumber").val(),
	    keyPerson,
	    'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
	    );
	    if(retInfo=="Y"){//点关闭按钮不新增

	    	 var p_Role_tmp;
	       if(keyPerson[0]=="1"){
         	p_Role_tmp="领导";
         }else if(keyPerson[0]=="2"){
         	p_Role_tmp="业务负责人";
         }else if(keyPerson[0]=="3"){
         	p_Role_tmp="联系人";
         }else if(keyPerson[0]=="4"){
         	p_Role_tmp="其他影响人";
         }

         var p_Sex_tmp;
         if(keyPerson[2]=="1"){
         	p_Sex_tmp="男";
         }else if(keyPerson[2]=="2"){
         	p_Sex_tmp="女";
         }

	       var newtrstr =
	          "<tr class=\"keyperson_contenttr\"   "+
  			  	" a_Role="+                     "'"+keyPerson[0] +"'"+
  			  	" a_PartyName="+                "'"+keyPerson[1] +"'"+
  			  	" a_Sex="+                      "'"+keyPerson[2] +"'"+
  			  	" a_ContactPhone="+             "'"+keyPerson[3] +"'"+
  			  	" a_Title="+                    "'"+keyPerson[4] +"'"+
  			  	" a_Alias="+                    "'"+keyPerson[5] +"'"+
  			  	" a_Birthday="+                 "'"+keyPerson[6] +"'"+
  			  	" a_Memorial="+                 "'"+keyPerson[7] +"'"+
  			  	" a_Mate="+                     "'"+keyPerson[8] +"'"+
  			  	" a_Secretary="+                "'"+keyPerson[9] +"'"+
  			  	" a_School="+                   "'"+keyPerson[10]+"'"+
  			  	" a_ClassMates="+               "'"+keyPerson[11]+"'"+
  			  	" a_Hobby="+                    "'"+keyPerson[12]+"'"+
  			  	" a_Leader="+                   "'"+keyPerson[13]+"'"+
  			  	" a_LeaderDept="+               "'"+keyPerson[14]+"'"+
  			  	" a_Vassal="+                   "'"+keyPerson[15]+"'"+
  			  	" a_Intercourse="+  	          "'"+keyPerson[16]+"'"+
  			  	" a_CustomerProvinceNumber="+  	"'"+keyPerson[17]+"'"+
  			  	" a_OperType= 'NEW'"+
  			  	">"+
						"<td classes=\"grey\"><input type=\"Checkbox\" name=\"KeyPersonListChkBox\">"+
					  "</td>"+
				    "<td><a class=\"p_PartyName\" style=\"cursor: hand;\">"+keyPerson[1]+"</a>"+
					  "</td>"+
					  "<td class=p_Role>"+p_Role_tmp+
					  "</td>"+
					  "<td class=p_Sex>"+p_Sex_tmp+
					  "</td>"+
					  "<td class=p_ContactPhone>"+keyPerson[3]+
					  "</td>"+
	          "</tr>";
	       $("#keyPerson_buttontr").before(newtrstr);
	       //注册更新函数
	       $('.p_PartyName').bind('click', KeyPersonUpdate);
	    }
	 }
	 //更新函数
	 function KeyPersonUpdate(){
	 	  var keyPerson = new Array(17);
      var keyPersonTR = $(this).parent().parent();
	 	  keyPerson=[
	 	  	        $(keyPersonTR).attr("a_Role"                  ),//0
	 	  	        $(keyPersonTR).attr("a_PartyName"             ),//1
	 	  	        $(keyPersonTR).attr("a_Sex"                   ),//2
	 	  	        $(keyPersonTR).attr("a_ContactPhone"          ),//3
	 	  	        $(keyPersonTR).attr("a_Title"                 ),//4
	 	  	        $(keyPersonTR).attr("a_Alias"                 ),//5
	 	  	        $(keyPersonTR).attr("a_Birthday"              ),//6
	 	  	        $(keyPersonTR).attr("a_Memorial"              ),//7
	 	  	        $(keyPersonTR).attr("a_Mate"                  ),//8
	 	  	        $(keyPersonTR).attr("a_Secretary"             ),//9
	 	  	        $(keyPersonTR).attr("a_School"                ),//10
	 	  	        $(keyPersonTR).attr("a_ClassMates"            ),//11
	 	  	        $(keyPersonTR).attr("a_Hobby"                 ),//12
	 	  	        $(keyPersonTR).attr("a_Leader"                ),//13
	 	  	        $(keyPersonTR).attr("a_LeaderDept"            ),//14
	 	  	        $(keyPersonTR).attr("a_Vassal"                ),//15
	 	  	        $(keyPersonTR).attr("a_Intercourse"           ),//16
	 	  	        $(keyPersonTR).attr("a_CustomerProvinceNumber"), //17
	 	  	        $("#p_Action").val()                  //18  操作类型
	 	  	        ];

	    var retInfo = window.showModalDialog
	    (
	    'f2002_KeyPerson_detail.jsp',
	    keyPerson,
	    'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	    );

	    //this.tr.attr赋值
	    $(keyPersonTR).attr("a_Role"                   , keyPerson[0] );
      $(keyPersonTR).attr("a_PartyName"              , keyPerson[1] );
      $(keyPersonTR).attr("a_Sex"                    , keyPerson[2] );
      $(keyPersonTR).attr("a_ContactPhone"           , keyPerson[3] );
      $(keyPersonTR).attr("a_Title"                  , keyPerson[4] );
      $(keyPersonTR).attr("a_Alias"                  , keyPerson[5] );
      $(keyPersonTR).attr("a_Birthday"               , keyPerson[6] );
      $(keyPersonTR).attr("a_Memorial"               , keyPerson[7] );
      $(keyPersonTR).attr("a_Mate"                   , keyPerson[8] );
      $(keyPersonTR).attr("a_Secretary"              , keyPerson[9]);
      $(keyPersonTR).attr("a_School"                 , keyPerson[10]);
      $(keyPersonTR).attr("a_ClassMates"             , keyPerson[11]);
      $(keyPersonTR).attr("a_Hobby"                  , keyPerson[12]);
      $(keyPersonTR).attr("a_Leader"                 , keyPerson[13]);
      $(keyPersonTR).attr("a_LeaderDept"             , keyPerson[14]);
      $(keyPersonTR).attr("a_Vassal"	 	             , keyPerson[15]);
      $(keyPersonTR).attr("a_Intercourse"            , keyPerson[16]);
      $(keyPersonTR).attr("a_CustomerProvinceNumber" , keyPerson[17]);

      $('.p_PartyName',keyPersonTR).text(keyPerson[1]);

      if(keyPerson[0]=="1"){
      	$('.p_Role',keyPersonTR).text("领导");
      }else if(keyPerson[0]=="2"){
      	$('.p_Role',keyPersonTR).text("业务负责人");
      }else if(keyPerson[0]=="3"){
      	$('.p_Role',keyPersonTR).text("联系人");
      }else if(keyPerson[0]=="4"){
      	$('.p_Role',keyPersonTR).text("其他影响人");
      }

      if(keyPerson[2]=="1"){
      	$('.p_Sex',keyPersonTR).text("男");
      }else if(keyPerson[2]=="2"){
      	$('.p_Sex',keyPersonTR).text("女");
      }

      $('.p_ContactPhone',keyPersonTR).text(keyPerson[3]);
	 }

	 //删除函数
   function KeyPersonDel(){
      $("input[@name='KeyPersonListChkBox']").each(function()
      {
      var checkTR = $(this.parentNode.parentNode);
      if($(this).attr("checked")){
      	  if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
      	  {         	  	  
      	  	  var ii  = $("DIV.KeyPerson","#hiddendate_delete").size();
      	  		var deletedate=
      	  		"<DIV class='KeyPerson'>" +
      	  		"<input type='text' name='tableid"+ii+"'        value='3'>" +
      	  		"<input type='text' name='opertype"+ii+"'       value='N'>" +
      	  		"<input type='text' name='d_Role"+ii+"'         value='"+$(checkTR).attr("a_Role")+"'>"+                         //人员角色           
      	  		"<input type='text' name='d_PartyName"+ii+"'    value='"+$(checkTR).attr("a_PartyName")+"'>"+                    //姓名               
      	  		"<input type='text' name='d_Sex"+ii+"'          value='"+$(checkTR).attr("a_Sex")+"'>"+                          //性别               
      	  		"<input type='text' name='d_ContactPhone"+ii+"' value='"+$(checkTR).attr("a_ContactPhone")+"'>"+                 //联系电话            
      	  		"<input type='text' name='d_Title"+ii+"'        value='"+$(checkTR).attr("a_Title")+"'>"+                        //职务               
      	  		"<input type='text' name='d_Alias"+ii+"'        value='"+$(checkTR).attr("a_Alias")+"'>"+                        //昵称               
      	  		"<input type='text' name='d_Memorial"+ii+"'     value='"+$(checkTR).attr("a_Memorial")+"'>"+                     //生日               
      	  		"<input type='text' name='d_Birthday"+ii+"'     value='"+$(checkTR).attr("a_Birthday")+"'>"+                     //纪念日             
      	  		"<input type='text' name='d_Mate"+ii+"'         value='"+$(checkTR).attr("a_Mate")+"'>"+                         //配偶姓名           
      	  		"<input type='text' name='d_Secretary"+ii+"'    value='"+$(checkTR).attr("a_Secretary")+"'>"+                    //秘书姓名           
      	  		"<input type='text' name='d_School"+ii+"'       value='"+$(checkTR).attr("a_School")+"'>"+                       //毕业院校           
              "<input type='text' name='d_ClassMates"+ii+"'   value='"+$(checkTR).attr("a_ClassMates")+"'>"+                  //同窗               
              "<input type='text' name='d_Hobby"+ii+"'        value='"+$(checkTR).attr("a_Hobby")+"'>"+                        //兴趣、爱好         
              "<input type='text' name='d_Leader"+ii+"'       value='"+$(checkTR).attr("a_Leader")+"'>"+                       //上级领导           
              "<input type='text' name='d_LeaderDept"+ii+"'   value='"+$(checkTR).attr("a_LeaderDept")+"'>"+                   //上级部门           
              "<input type='text' name='d_Vassal"+ii+"'       value='"+$(checkTR).attr("a_Vassal")+"'>"+                       //下级部门           
              "<input type='text' name='d_Intercourse"+ii+"'  value='"+$(checkTR).attr("a_Intercourse")+"'>"+                  //社交圈             
              "<input type='text' name='d_CustomerProvinceNumber_KeyPerson"+ii+"' value='"+$(checkTR).attr("a_CustomerProvinceNumber")+"'>"+       //集团归属省编码     
              "</DIV>";                                                                                                            
      	  		$("#hiddendate_delete").append(deletedate);                                                                          
      	  }          
       		checkTR.remove();
      }
      })
   }
});
</script>
