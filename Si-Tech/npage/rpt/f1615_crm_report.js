//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_crm_bao(statement)
{
  if(statement)
  {
    with(statement) {
      if(rpt_type.value==7) {
        hTableName.value="rvo005";
        hParams1.value= "prc_1615_vo005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==5) {
        hTableName.value="rfo005";
        hParams1.value= "prc_1615_fo005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==16) {
        hTableName.value="rfo006";
        hParams1.value= "prc_1247_pr003_upg('"+workNo.value+"','"+rptRight.value+"','"+login_no.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==24) {
        hTableName.value="rjo005";
        hParams1.value= "prc_1247_pr005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==27) {
        hTableName.value="rjo005";
        hParams1.value= "prc_1247_pr0017_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==28) {
        hTableName.value="rjo005";
        hParams1.value= "PRC_1246_1_UPG('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==29) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1247_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==30) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1248_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==31) {
        hTableName.value="rfo006";
        hParams1.value= "PRC_9000_1_upg('"+rptRight.value+"','"+groupId.value+"',' ',' ','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==32) {
        hTableName.value="rfo006";
        hParams1.value= "PRC_9001_1_upg('"+rptRight.value+"','"+groupId.value+"',' ',' ','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==34) {
        hTableName.value="rcd002";
        hParams1.value= "prc_9002_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==82) {
        hTableName.value="rcd002";
        hParams1.value= "prc_2289_zj_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==92) {
	hTableName.value="rfo006";
	hParams1.value= "prc_1364_mx_rpt_upg('"+rptRight.value+"','"+groupId.value+"',' ',' ','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==103) {
        hTableName.value="rpt2266";
        hParams1.value= "prc_2266_rpt15_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==110) {
        hTableName.value="rbo005";
        hParams1.value= "prc_1615_po0110_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==155) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2146_155_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==156) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2146_156_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      }else if(rpt_type.value==338) {
        hTableName.value="rbo006";

        hParams1.value= "prc_2146_338_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"', '"+end_time.value+"','ZZZZ'";
        action="print_rpt_crm_report.jsp";
      }
       else if(rpt_type.value==339) {
        hTableName.value="rbo006";

        hParams1.value= "prc_2146_339_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"', '"+end_time.value+"','ZZZZ'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==340) {
        hTableName.value="rcr001";
        hParams1.value= "prc_2146_340_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"', '"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      }
      else if(rpt_type.value==374) {
    	  hTableName.value="t1788rpt";
	      hParams1.value= "prc_1615_374_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm_report.jsp";
      }
    }
  }
}
