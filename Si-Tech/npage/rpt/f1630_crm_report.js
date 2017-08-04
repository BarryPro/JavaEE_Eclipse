//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_crm_bao(statement)
{
	if(statement)
	{
		with(statement) 
		{

			if(rpt_type.value==1) {
				hTableName.value="rbd002";
				hParams1.value= "prc_1630_bd002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==2) {
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pd002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==33) {
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr0015_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==44) {
				hTableName.value="rPo006";
				hParams1.value="prc_1610_po006_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==123) {
				hTableName.value="rfo006";
				hParams1.value= "prc_1364_mx_rpt_upg('"+rptright.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==124) {
				hTableName.value="rfo006";
				hParams1.value= "prc_1364_rpt_upg('"+rptright.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==133) {
				hTableName.value="RCR7722";
				hParams1.value= "prc_2225_tj3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==162) {
				hTableName.value="rpt003";
				hParams1.value= "prc_1630_rpt162_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==5) {
				hTableName.value="rfd002";
				hParams1.value= "prc_1630_fd002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==6) {
				hTableName.value="rtd002";
				hParams1.value= "prc_1630_td002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==11) {
				hTableName.value="rtd002";
				hParams1.value= "prc_1630_td002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==17) {
				hTableName.value="rfo006";
				hParams1.value= "prc_1677_003Prn_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==28) {
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr0011_2_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==29) {
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr0011_2_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==30) {
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr0012_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==154) {
				if(groupName.value=='')
				{
					rdShowMessageDialog("请选择组织节点!");
					return false;
				}
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0154_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==155) {
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0155_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==156) {
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0156_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==157) {
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0157_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==174) {
				hTableName.value="rbo006";
				hParams1.value= "PRC_1630_makeUpSim_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==206) { //20101207 区县电子化工单打印统计表
				hTableName.value="rbd002";
				hParams1.value= "prc_1630_hwprt_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";

				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==314) { //2011/11/16 diling添加 区县sim补卡统计报表
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_314_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==330) {
				hTableName.value="rbo006";
				hParams1.value= "prc_2148_330_upg('"+document.form1.workNo.value+"','"
				+document.form1.groupId.value+"','"
				+document.form1.bGroupId.value+"','"
				+document.form1.eGroupId.value+"','"
				+document.form1.begin_time.value+" 00:00:00','"
				+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			} else if(rpt_type.value==338) {
				hTableName.value="rbo006";
				hParams1.value= "prc_2148_338_upg('"+document.form1.workNo.value+"','"
				+document.form1.groupId.value+"','"
				+document.form1.bGroupId.value+"','"
				+document.form1.eGroupId.value+"','"
				+document.form1.begin_time.value+" 00:00:00','"
				+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";


      } else if(rpt_type.value==4) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1630_cd002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==13) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1247_pr003_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"'";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==31) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1247_pr0013_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==32) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1247_pr0014_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==34) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1247_pr0016_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==35) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1247_pr0017_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==36) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1246_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==37) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1247_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==38) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1248_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==39) {
        hTableName.value="rfo006"; hParams1.value="prc_9000_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==40) {
        hTableName.value="rfo006";
        hParams1.value="prc_9001_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==47) {
        hTableName.value="rcd002";
        hParams1.value="prc_1253_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==53) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1630_rpt1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==54) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1630_rpt2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==56) {
        hTableName.value="rpd002";
        hParams1.value= "prc_1630_pd056_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==59) {
        hTableName.value="rcd002";
        hParams1.value= "prc_1256_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==85) {
        hTableName.value="rpd002";
        hParams1.value= "prc_1630_pd085_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==86) {
        hTableName.value="rpd002";
        hParams1.value= "prc_1630_pd086_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==88) {
        hTableName.value="rpd002";
        hParams1.value= "prc_1630_pd088_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==90) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1630_rpt3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==112) {
        hTableName.value="rcd002";
        hParams1.value= "prc_2289_zj_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==148) {
        hTableName.value="RPT2266";
        hParams1.value= "prc_2266_rpt30_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==160) {
        hTableName.value="rpt003";
        hParams1.value= "prc_1630_rpt160_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==165) {
        hTableName.value="t1788rpt";
        hParams1.value= "prc_1630_rpt4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==172) {
        hTableName.value="rpd002";
        hParams1.value= "PRC_1630_PD0175_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==175) {
        hTableName.value="rbr001";
        hParams1.value= "prc_1630_4a00_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==176) {
        hTableName.value="rbr001";
        hParams1.value= "prc_1630_4a02_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==312) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2148_312_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      } else if(rpt_type.value==313) {
        hTableName.value="rbo006";
        hParams1.value= "prc_2148_313_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
        action="print_rpt_crm_report.jsp";
      }
		else if(rpt_type.value==322)
		{
			hTableName.value="rpd002";
			hParams1.value= "prc_2148_322_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+bGroupId.value+"','"
				+eGroupId.value+"','"
				+begin_time.value+"','"
				+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==323)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_2148_323_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+bGroupId.value+"','"
				+eGroupId.value+"','"
				+begin_time.value+"','"
				+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			}else if(rpt_type.value==326)
			{
				hTableName.value="RCR001";
				hParams1.value= "prc_2148_326_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+bGroupId.value+"','"
				+eGroupId.value+"','"
				+begin_time.value+"','"
				+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==327)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_327_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+bGroupId.value+"','"
				+eGroupId.value+"','"
				+begin_time.value+"','"
				+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==329)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_329_upg('"+workNo.value+"','"
				+groupId.value+"','"
				+bGroupId.value+"','"
				+eGroupId.value+"','"
				+begin_time.value+"','"
				+end_time.value+"' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==331) { /* 区县实收统计表一（旧版） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt1_upg_old('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==332) { /* 区县实收统计表二（旧版） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt2_upg_old('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==333) { /* 区县实收统计报表三（旧版） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt3_upg_old('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==334) { /* 区县实收统计报表四（旧版） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt4_upg_old('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==335) { /* 区县实收统计表一（旧版2） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt1_upg_old2('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==336) { /* 区县实收统计表二（旧版2） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt2_upg_old2('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==337) { /* 区县实收统计报表三（旧版2） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt3_upg_old2('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==343) { /* 区县实收统计表一(201504前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_343_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==344) { /* 区县实收统计表二(201504前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_344_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==345) { /* 区县实收统计表三(201504前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_345_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==346) { /* 区县实收统计表四(201504前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_346_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==353)
			{
				hTableName.value="t1788rpt";
				hParams1.value= "prc_2148_353_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==354) { /* 354->区县实收统计表一(2016年6月前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt1_upg_354('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==355) { /* 355->区县实收统计表二(2016年6月前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt2_upg_355('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==356) { /* 356->区县实收统计表三(2016年6月前) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_rpt3_upg_356('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==358) { /* 358->区县异地工号操作报表*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_2148_358_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==361) { /* 361->区县实收统计报表三(2017年2月前)*/
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1630_361_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm_report.jsp";
			}
		}
	}
}