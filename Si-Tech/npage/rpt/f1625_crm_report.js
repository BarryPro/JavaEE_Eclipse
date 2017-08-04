/**
 * wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
 * wanghfa 20100607 增加了报表格式的解耦
 **/

function select_crm_bao(statement)
{
  if(statement)
  {
    with(statement) 
    {  
      if(rpt_type.value==1) {
          document.all("rpt_format").options.length=6;
          document.all("rpt_format").options[0].text='明细';
          document.all("rpt_format").options[0].value='10000';
          document.all("rpt_format").options[1].text='工号小计';
          document.all("rpt_format").options[1].value='01000';
          document.all("rpt_format").options[2].text='操作小计';
          document.all("rpt_format").options[2].value='00100';
          document.all("rpt_format").options[3].text='明细+工号小计';
          document.all("rpt_format").options[3].value='11000';
          document.all("rpt_format").options[4].text='明细+操作小计';
          document.all("rpt_format").options[4].value='10100';
          document.all("rpt_format").options[5].text='明细+工号小计+操作小计';
          document.all("rpt_format").options[5].value='11100';
        
        hTableName.value="rbt003";
        hParams1.value= "prc_1625_bt003_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==7) {
          document.all("rpt_format").options.length=8;
          document.all("rpt_format").options[0].text='明细';
          document.all("rpt_format").options[0].value='10000';
          document.all("rpt_format").options[1].text='工号小计';
          document.all("rpt_format").options[1].value='01000';
          document.all("rpt_format").options[2].text='操作小计';
          document.all("rpt_format").options[2].value='00100';
          document.all("rpt_format").options[3].text='优惠小计';
          document.all("rpt_format").options[3].value='00010';
          document.all("rpt_format").options[4].text='明细+工号小计';
          document.all("rpt_format").options[4].value='11000';
          document.all("rpt_format").options[5].text='明细+操作小计';
          document.all("rpt_format").options[5].value='10100';
          document.all("rpt_format").options[6].text='明细+优惠小计';
          document.all("rpt_format").options[6].value='10010';
          document.all("rpt_format").options[7].text='明细+工号小计+操作小计+优惠小计';
          document.all("rpt_format").options[7].value='11110';

        hTableName.value="rvt003";
        hParams1.value= "prc_1625_vt003_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==13) {
        hTableName.value="rct003";
        hParams1.value= "prc_1247_pr003_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==22) {
        hTableName.value="rct003";
        hParams1.value= "prc_1247_pr005_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==34) {
        hTableName.value="rct003";
        hParams1.value= "prc_1247_pr0014_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==36) {
        hTableName.value="rct003";
        hParams1.value= "prc_1247_pr0016_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==39) {
        hTableName.value="rct003";
        hParams1.value= "prc_1247_pr0017_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==40) {
        hTableName.value="rct003";
        hParams1.value= "prc_1246_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==41) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1247_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==42) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1248_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==43) {
        hTableName.value="rfo006";
        hParams1.value= "prc_9000_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==44) {
        hTableName.value="rfo006";
        hParams1.value= "prc_9001_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==45) {
        hTableName.value="rct003";
        hParams1.value= "prc_9002_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==55) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1625_rpt1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==56) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1625_rpt2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==58) {
        hTableName.value="rpt003";
        hParams1.value= "prc_1625_pt058_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==59) {
        hTableName.value="rpt003";
        hParams1.value= "prc_1625_pt059_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==86) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1625_rpt3_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==106) {
        hTableName.value="rcd002";
        hParams1.value= "prc_2289_zj_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==131) {
        hTableName.value="RPT2266";
        hParams1.value= "prc_2266_rpt25_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==138) {
	hTableName.value="rpt003";
	hParams1.value= "prc_1625_pt0138_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==139) {
	hTableName.value="rpt003";
	hParams1.value= "prc_1625_pt0139_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==144) {
        hTableName.value="rpt003";
        hParams1.value= "prc_1625_rpt144_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==150) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1625_rpt4_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==159) {
        hTableName.value="rbr001";
        hParams1.value= "prc_1625_4a02_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==167) {
        hTableName.value="rbo006";
        hParams1.value= "prc_1625_pt167_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==171) {
        hTableName.value="rbo006";
        hParams1.value= "prc_1625_pt1500_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==172) {
        hTableName.value="rbo006";
        hParams1.value= "prc_1625_pt1933_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";        
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==173) {
        hTableName.value="rbo006";
        hParams1.value= "prc_1625_pt1555_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";        
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==174) {
        hTableName.value="rbo006";
        hParams1.value= "prc_1625_pt1556_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";        
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==211) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2147_211_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";        
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==212) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2147_212_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";        
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==323) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2147_323_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";        
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==326) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2147_1104_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";        
        action="print_rpt_crm_report.jsp";
      }
		else if(rpt_type.value==329)
		{
			hTableName.value="rpd002";
			hParams1.value= "prc_2147_329_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+begin_login.value+"','"
				+end_login.value+"','"
				+begin_time.value+"','"
				+end_time.value+"'";				
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==333)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_2147_333_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+begin_login.value+"','"
				+end_login.value+"','"
				+begin_time.value+"','"
				+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==334)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_2147_334_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+begin_login.value+"','"
				+end_login.value+"','"
				+begin_time.value+"','"
				+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==336)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2147_336_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+begin_login.value+"','"
				+end_login.value+"','"
				+begin_time.value+"','"
				+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==338)
			{
				hTableName.value="rbt003";
				hParams1.value= "prc_1625_BT338_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+begin_login.value+"','"
				+end_login.value+"','"
				+begin_time.value+"','"
				+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==339) {  /* 营业员实收统计报表一（旧版）*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt1_upg_old('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==340) {  /* 营业员实收统计报表二（旧版）*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt2_upg_old('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==341) {  /* 营业厅实收统计报表三（旧版）*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt3_upg_old('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==342) { /* 营业厅实收统计报表四（旧版）*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt4_upg_old('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==343) { /* 营业员实收统计报表一（旧版2）*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt1_upg_old2('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==344) { /* 营业员实收统计报表二（旧版2）*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt2_upg_old2('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==345) { /* 营业厅实收统计报表三（旧版2）*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt3_upg_old2('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==117) {
				hTableName.value="rfo006";
				hParams1.value= "prc_1364_mx_rpt_upg('T','"+groupId.value+"',' ',' ','"+workNo.value+"','"+begin_login.value+"|"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==118) {
				hTableName.value="rfo006";
				hParams1.value= "prc_1364_rpt_upg('T','"+groupId.value+"',' ',' ','"+workNo.value+"','"+begin_login.value+"|"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==352) { /* 营业厅实收统计报表一(201504前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "PRC_1625_352_UPG('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==353) { /* 营业厅实收统计报表二(201504前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_353_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==354) { /* 营业厅实收统计报表三(201504前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_354_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==355) { /* 营业厅实收统计报表四(201504前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_355_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==363)
			{
				hTableName.value="t1788rpt";
				hParams1.value= "prc_2147_363_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==364)
			{
				hTableName.value="t1788rpt";
				hParams1.value= "prc_2147_364_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==365) { /* 365->营业厅实收统计报表一(2016年6月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt1_upg_365('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==366) {/* 366->营业厅实收统计报表二(2016年6月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt2_upg_366('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==367) { /* 367->营业厅实收统计报表三(2016年6月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_rpt3_upg_367('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==369) { /* 369->营业厅异地工号操作报表*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_2147_369_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==372) { /* 372->营业厅实收统计报表三(2017年2月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1625_372_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
		}
	}
}
