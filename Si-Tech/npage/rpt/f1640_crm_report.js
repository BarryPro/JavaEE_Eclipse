//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_crm_bao(statement)
{
  if(statement)
  {
    with(statement)
    {
      if(rpt_type.value==1) {
        hTableName.value="rbr001";
        hParams1.value= "prc_1640_br001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";





			} else if(rpt_type.value==2) {
				hTableName.value="rpr001";
				hParams1.value= "prc_1640_pr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==129) {
				hTableName.value="rfo006";
				hParams1.value= "prc_1364_mx_rpt_upg('"+rptRight.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==130) {
				hTableName.value="rfo006";
				hParams1.value= "prc_1364_rpt_upg('"+rptRight.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==139) {
				hTableName.value="RCR7722";
				hParams1.value= "prc_2225_tj_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' "; 
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==140) {
				hTableName.value="rcr7722";
				hParams1.value=  "prc_2225_mx_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";  
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==170) {
				hTableName.value="rjo005";
				hParams1.value= "prc_5260_pr0170_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==32) {
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr0015_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==4) {
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_cr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==229) { //20101207 区县电子化工单打印统计表
				hTableName.value="rbr001";
				hParams1.value= "prc_1640_hwprt_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm_report.jsp";




      } else if(rpt_type.value==5) {
        hTableName.value="rfr001";
        hParams1.value= "prc_1640_fr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==13) {
        hTableName.value="rjo005";
        hParams1.value= "prc_1247_pr003_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==22) {
        hTableName.value="rcr001";
        hParams1.value= "prc_1247_pr006_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==27) {
        hTableName.value="rcr001";
        hParams1.value= "prc_1247_pr0011_3_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==28) {
        hTableName.value="rcr001";
        hParams1.value= "prc_1247_pr0011_3_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==31) {
        hTableName.value="rcr001";
        hParams1.value= "prc_1247_pr0014_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==32) {
        hTableName.value="rcr001";
        hParams1.value= "prc_1247_pr0015_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==34) {
        hTableName.value="rcr001";
        hParams1.value= "prc_1247_pr0017_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==36) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1247_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==37) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1248_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==38) {
        hTableName.value="rfo006";
        hParams1.value= "prc_9000_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==39) {
        hTableName.value="rfo006";
        hParams1.value=  "prc_9001_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==44) {
        hTableName.value="rcd002";
        hParams1.value= "prc_9002_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==46) {
        hTableName.value="rcr001";
        hParams1.value= "prc_1253_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==54) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1640_rpt1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==55) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1640_rpt2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==57) {
        hTableName.value="rjo005";
        hParams1.value= "prc_1247_pr057_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==60) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1256_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==83) {
        hTableName.value="rjo005";
        hParams1.value= "prc_1247_pr083_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==90) {
        hTableName.value="rjo005";
        hParams1.value= "prc_1247_pr090_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==91) {
        hTableName.value="rjo005";
        hParams1.value= "prc_1247_pr091_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==94) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1640_rpt3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==108) {
        hTableName.value="rcd002";
        hParams1.value= "prc_2289_zj_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==110) {
        hTableName.value="rcr001";
        hParams1.value= "prc_1247_dq_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==111) {
        hTableName.value="rcr001";
        hParams1.value= "prc_1247_dq_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==145){
        hTableName.value="RPT2266";
        hParams1.value= "prc_2266_rpt40_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==151) {
        hTableName.value="rjo005";
        hParams1.value= "prc_1247_pr0151_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==153) {
        hTableName.value="rjo005";
        hParams1.value= "prc_1247_pr0153_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==158) {
        hTableName.value="rpt003";
        hParams1.value= "prc_1640_rpt158_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==165){
        hTableName.value="rpt003";
        hParams1.value= "prc_7162_rpt160_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==167) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1640_rpt4_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==175) {
        hTableName.value="rbr001";
        hParams1.value= "prc_1640_4a00_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==176) {
        hTableName.value="rbr001";
        hParams1.value= "prc_1640_4a02_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==219) { //fusk 20100928 9:52:50 关于绥化公司需求开发的请示 添加2289地区报表
          hTableName.value="rvr001";
          hParams1.value= "prc_2289_vr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
          action="print_rpt_crm_report.jsp";
      } else if(document.form1.rpt_type.value==231) {
        hTableName.value="dbo005";
        hParams1.value= "prc_1640_newsale_op_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      }  else if(document.form1.rpt_type.value==318) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2149_318_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+" 00:00:00','"+document.form1.end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(document.form1.rpt_type.value==319) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2149_319_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+" 00:00:00','"+document.form1.end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(document.form1.rpt_type.value==324) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1640_rpt5_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+" 00:00:00','"+document.form1.end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==325) {
        hTableName.value="rpd002";
        hParams1.value= "PRC_1640_PD0325_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      }
		
		else if(rpt_type.value==330)
		{
			hTableName.value="rpd002";
			hParams1.value= "prc_2149_330_upg('"+document.form1.workNo.value
				+"','"+document.form1.groupId.value
				+"','"+document.form1.bGroupId.value
				+"','"+document.form1.eGroupId.value
				+"','"+document.form1.begin_time.value+"','"
				+document.form1.end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}	
			else if(rpt_type.value==331)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_2149_331_upg('"+document.form1.workNo.value
				+"','"+document.form1.groupId.value
				+"','"+document.form1.bGroupId.value
				+"','"+document.form1.eGroupId.value
				+"','"+document.form1.begin_time.value+"','"
				+document.form1.end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==338)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_338_upg('"+document.form1.workNo.value
				+"','"+document.form1.groupId.value
				+"','"+document.form1.bGroupId.value
				+"','"+document.form1.eGroupId.value
				+"','"+document.form1.begin_time.value+"','"
				+document.form1.end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==339)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_339_upg('"+document.form1.workNo.value
				+"','"+document.form1.groupId.value
				+"','"+document.form1.bGroupId.value
				+"','"+document.form1.eGroupId.value
				+"','"+document.form1.begin_time.value+"','"
				+document.form1.end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}	
			else if(rpt_type.value==341)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_341_upg('"+document.form1.workNo.value
				+"','"+document.form1.groupId.value
				+"','"+document.form1.bGroupId.value
				+"','"+document.form1.eGroupId.value
				+"','"+document.form1.begin_time.value+"','"
				+document.form1.end_time.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==343) { /* 地区实收统计表一（旧版） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt1_upg_old('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==344) { /* 地区实收统计表二（旧版） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt2_upg_old('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==345) { /* 地区实收统计报表三（旧版） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt3_upg_old('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==346) { /* 地区实收统计报表四（旧版） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt4_UPG_old('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==347) { /* 地区实收统计表一（旧版2） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt1_upg_old2('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==348) { /* 地区实收统计表二（旧版2） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt2_upg_old2('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==349) { /* 地区实收统计报表三（旧版2） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt3_upg_old2('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==354) { /* 电商营业收款统计报表一 */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_354_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==355) { /* 电商营业收款统计报表二 */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_355_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==356) { /* 电商营业收款统计报表三 */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_356_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==360) { /* 地区实收统计表一(201504前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_360_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==361) { /* 地区实收统计表二(201504前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_361_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==362) { /* 地区实收统计表三(201504前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_362_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==363) { /* 地区实收统计表四(201504前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_363_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==373)
			{
				hTableName.value="t1788rpt";
				hParams1.value= "prc_2149_373_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==374) { /* 374->地区实收统计表一(2016年6月前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt1_upg_374('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==375) { /* 375->地区实收统计表二(2016年6月前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt2_upg_375('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==376) { /*376->地区实收统计表三(2016年6月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_rpt3_upg_376('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==379) { /* 379->电商营业收款统计报表一(2016年6月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_354_upg_379('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==378) { /* 378->电商营业收款统计报表二(2016年6月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_355_upg_378('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==377) { /* 377->电商营业收款统计报表三(2016年6月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_356_upg_377('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==386) { /* 386->地区实收统计报表三(2017年2月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_386_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==387) { /* 387->电商营业收款统计报表三(2017年2月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1640_387_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
		}
	}
}
