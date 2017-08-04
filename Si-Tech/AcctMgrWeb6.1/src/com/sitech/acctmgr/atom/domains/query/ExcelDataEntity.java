package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
public class ExcelDataEntity implements Serializable {

    private static final long serialVersionUID = -6905688443692991940L;

    @JSONField(name = "EXCEL_SHEET_NAME")
    @ParamDesc(path = "EXCEL_SHEET_NAME", cons = ConsType.CT001, type = "String", len = "100", desc = "excel中sheeet名称", memo = "略")
    private String excelSheetName;
    @JSONField(name = "EXCEL_DATA_COLS")
    @ParamDesc(path = "EXCEL_DATA_COLS", cons = ConsType.QUES, type = "String", len = "20", desc = "excel中列数", memo = "略")
    private String excelDataCols;
    @JSONField(name = "EXCEL_DATA_LIST")
    @ParamDesc(path = "EXCEL_DATA_LIST", cons = ConsType.QUES, type = "compx", len = "", desc = "excel中表格一行的数据", memo = "表格一行的数据，每列用竖线(|)分隔")
    private List<ExcelListEntity> excelDataList;
    @JSONField(name = "EXCEL_DATA_HEAD")
    @ParamDesc(path = "EXCEL_DATA_HEAD", cons = ConsType.QUES, type = "compx", len = "", desc = "excel中表格表头数据", memo = "")
    private List<List<ExcelHeadEntity>> excelHeadList;


    /**
     * @return the excelSheetName
     */
    public String getExcelSheetName() {
        return excelSheetName;
    }

    /**
     * @param excelSheetName the excelSheetName to set
     */
    public void setExcelSheetName(String excelSheetName) {
        this.excelSheetName = excelSheetName;
    }

    /**
     * @return the excelDataCols
     */
    public String getExcelDataCols() {
        return excelDataCols;
    }

    /**
     * @param excelDataCols the excelDataCols to set
     */
    public void setExcelDataCols(String excelDataCols) {
        this.excelDataCols = excelDataCols;
    }

    /**
     * @return the excelDataList
     */
    public List<ExcelListEntity> getExcelDataList() {
        return excelDataList;
    }

    /**
     * @param excelDataList the excelDataList to set
     */
    public void setExcelDataList(List<ExcelListEntity> excelDataList) {
        this.excelDataList = excelDataList;
    }

    /**
     * @return the excelHeadList
     */
    public List<List<ExcelHeadEntity>> getExcelHeadList() {
        return excelHeadList;
    }

    /**
     * @param excelHeadList the excelHeadList to set
     */
    public void setExcelHeadList(List<List<ExcelHeadEntity>> excelHeadList) {
        this.excelHeadList = excelHeadList;
    }
}
