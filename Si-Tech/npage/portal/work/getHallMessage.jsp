<%
   /*
   * 功能: 营业厅现场管理查询我接收的信息和营销信息
　 * 版本: v1.0
　 * 日期: 2015/12/1 15:31:26
　 * 版权: sitech
	 * gaopeng
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
       //禁止IE缓存页面
	  response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	  response.setHeader("Pragma","no-cache"); //HTTP 1.0
	  response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
	  String  powerCode= (String)session.getAttribute("powerCode");
	  String groupId = (String)session.getAttribute("groupId");
		
		String syscount = "";
		String percount = "";
		
		String receSql = "select to_char(dip.INFO_ID) as INFO_ID, "
		+" dip.INFO_TITLE"
		+" from dboprtadm.IMS_INFOPUBLIS dip "
		+" left join dboprtadm.sys_login_msg slm1 "
		+" on dip.CREATE_LOGIN_NO = slm1.login_no "
		+" left join dboprtadm.sys_login_msg slm2 "
		+" on dip.handler_no = slm2.login_no "
		+" left join (select distinct (iib1.info_id), 'Y' as login_is_read "
		+" from dboprtadm.IMS_INFOPUBLIS_BROWSE iib1 "
		+" where iib1.browse_login_no ='aaaaxp') IMS_INFOPUBLIS_BROWSE_L1 "
		+" on dip.info_id = IMS_INFOPUBLIS_BROWSE_L1.INFO_ID "
		+" left join (select iib.info_id, count(*) as BROWSE_num "
		+" from dboprtadm.IMS_INFOPUBLIS_BROWSE iib "
		+" group by iib.info_id) IMS_INFOPUBLIS_BROWSE_L "
		+" on dip.info_id = IMS_INFOPUBLIS_BROWSE_L.info_id "
		+" left join (select iir.info_id, count(*) as REPLY_num "
		+" from dboprtadm.IMS_INFOPUBLIS_REPLY iir "
		+" group by iir.info_id) IMS_INFOPUBLIS_REPLY_L "
		+" on dip.info_id = IMS_INFOPUBLIS_REPLY_L.info_id "
		+" where dip.INFO_ID in "
		+" (select distinct (iir.info_id) "
		+" from dboprtadm.ims_info_receive iir "
		+" where (iir.i_type = 'L' and iir.i_value ='aaaaxp') "
		+" or (iir.i_type = 'G' and "
		+" iir.i_value in "
		+" (select icm.circle_id "
		+" from dboprtadm.ims_circle_members icm "
		+" where icm.members_id = "
		+" (select iim.members_id "
		+" from dboprtadm.ims_info_members iim "
		+" where iim.login_no ='aaaaxp'))) "
		+" or (iir.i_type = 'R' and "
		+" iir.i_value = "
		+" (select slm_i.group_id "
		+" from dboprtadm.sys_login_msg slm_i "
		+" where slm_i.login_no ='aaaaxp'))) "
		+" and dip.HANDLER_APP_STATUS = 'IOK' "
		+" and ((dip.info_timing is not null and dip.info_effective is null and "
		+" dip.info_timing < sysdate) or "
		+" (dip.info_timing is null and dip.info_effective is not null and "
		+" dip.info_effective > sysdate) or "
		+" (dip.info_timing is null and dip.info_effective is null) or "
		+" (dip.info_timing is not null and dip.info_effective is not null and "
		+" dip.info_timing < sysdate and dip.info_effective > sysdate))  "
		+" and dip.INFO_LEVEL in ('A','B')  and rownum < 10 "
		+" order by create_time desc ";
		String receive_no = "loginNo1="+workNo+",loginNo2="+workNo+",loginNo3="+workNo+",loginNo4="+workNo;
	
		String receSql2 = "select * "
		+" from (select row_.*, rownum rownum_ "
		+" from (select t1.project_id, "
		+" t1.project_name "
		+" ,t1.create_time "
		+" from dboprtadm.mkt_project t1, dboprtadm.sys_login_msg t5, dboprtadm.sys_group_msg t6  "
		+" where t1.creater_login_no = t5.login_no"
		+" and t1.status = 'Y'"
		+" and t5.group_id = t6.group_id "
		+" and t1.creater_login_no =:loginNo"
		+" union  "
		+" select distinct t1.project_id, "
		+" t1.project_name"
		+" ,t1.create_time "
		+"  from dboprtadm.mkt_project        t1, "
		+" dboprtadm.mkt_publish_region t2, "
		+" dboprtadm.sys_group_info     t3,"
		+"  dboprtadm.sys_login_msg      t5,  "
		+"  dboprtadm.sys_group_msg      t6 "
		+"   where t1.project_id = t2.project_id  "
		+" and t2.group_id = t3.parent_group_id "
		+"  and t3.group_id =:groupId "
		+"  and t1.creater_login_no = t5.login_no"
		+"  and t1.status = 'Y'"
		+" and t5.group_id = t6.group_id "
		+" ) row_ "
		+" where rownum <= 10 order by row_.create_time desc)"
		+" where rownum_ >= 1";
		
		String receive_no2 = "loginNo="+workNo+",groupId="+groupId;
		/*
			select *
  from (select row_.*, rownum rownum_
          from (select t1.project_id,
                       t1.project_name,
                       t1.project_desc,
                       to_char(t1.begin_time, 'yyyymmdd hh24:mi:ss') as begin_time,
                       to_char(t1.end_time, 'yyyymmdd hh24:mi:ss') as end_time,
                       t1.creater_login_no,
                       to_char(t1.create_time, 'yyyymmdd hh24:mi:ss') as create_time,
                       t5.login_name,
                       t6.group_name
                  from mkt_project t1, sys_login_msg t5, sys_group_msg t6
                 where t1.creater_login_no = t5.login_no
                   and t1.status = 'Y'
                   and t5.group_id = t6.group_id
                   and t1.creater_login_no = 'aaaaxp'
                union
                select distinct t1.project_id,
                                t1.project_name,
                                t1.project_desc,
                                to_char(t1.begin_time, 'yyyymmdd hh24:mi:ss') as begin_time,
                                to_char(t1.end_time, 'yyyymmdd hh24:mi:ss') as end_time,
                                t1.creater_login_no,
                                to_char(t1.create_time, 'yyyymmdd hh24:mi:ss') as create_time,
                                t5.login_name,
                                t6.group_name
                  from mkt_project        t1,
                       mkt_publish_region t2,
                       sys_group_info     t3,
                       sys_login_msg      t5,
                       sys_group_msg      t6
                 where t1.project_id = t2.project_id
                   and t2.group_id = t3.parent_group_id
                   and t3.group_id = '10031'
                   and t1.creater_login_no = t5.login_no
                   and t1.status = 'Y'
                   and t5.group_id = t6.group_id
                 order by create_time desc) row_
         where rownum <= 10)
 where rownum_ >= 1
		
		*/
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="2"> 
    <wtc:param value="<%=receSql %>"/>
    
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>
  	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail2" retmsg="retMessage_mail2" outnum="9"> 
    <wtc:param value="<%=receSql2 %>"/>
    <wtc:param value="<%=receive_no2 %>"/>
    	
  </wtc:service>  
  <wtc:array id="result_mail2"  scope="end"/>

<table width="100%" border=0 cellpadding="0" cellspacing=1 cellpadding="0" class="list">
					<tr>
						<th>我接收的信息</th>
					</tr>
					<% 
					System.out.println("gaopengSeeLog==============result_mail.length==="+result_mail.length);
					//String hallIp = "10.110.13.52:10076";
					//生产
					String hallIp = "10.110.2.229:11000";
					String path = "http://"+hallIp+"/hallmanage/simplesso/simplesso_hlj/"+workNo+"/|InfoPublisManageAction|InforMat_I_Rece/infoId=";
					if(result_mail.length > 0){%>
						<% for(int i=0;i<result_mail.length;i++){%>
					<tr>
						<td><a href="javascript:void(0);" onclick="showMsg('<%=path%><%=result_mail[i][0]%>');"><%=result_mail[i][1]%></a></td>
					</tr>
					<% }%>
					<%}%>
</table>

<table width="100%" border=0 cellpadding="0" cellspacing=1 cellpadding="0" class="list">
					<tr>
						<th>我接收的营销活动</th>
					</tr>
					<% 
					System.out.println("gaopengSeeLog==============result_mail.length==="+result_mail.length);
					
					String path2 = "http://"+hallIp+"/hallmanage/simplesso/simplesso_hlj/"+workNo+"/|mkt|projectInfo/projectId=";
					if(result_mail.length > 0){%>
						<% for(int i=0;i<result_mail2.length;i++){%>
					<tr>
						<td><a href="javascript:void(0);" onclick="showMsg('<%=path2%><%=result_mail2[i][0]%>');"><%=result_mail2[i][1]%></a></td>
					</tr>
					<% }%>
					<%}%>
</table>



<script language="JavaScript">
		function showMsg(path){
				var iWidth = window.screen.availWidth-400; //弹出窗口的宽度;
				var iHeight = window.screen.availHeight-300; //弹出窗口的高度;
				window.open(path, 'newwindow', 'height='+iHeight+', width='+iWidth+', top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no');
			
		}
</script>