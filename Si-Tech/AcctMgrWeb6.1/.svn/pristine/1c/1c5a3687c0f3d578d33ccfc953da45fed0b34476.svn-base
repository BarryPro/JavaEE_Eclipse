package com.sitech.acctmgr.atom.domains.detail;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class DynamicTable implements Serializable {

    @JSONField(name = "ELEMENT_ID")
    private String elementId = "detail_dynamic_div"; /*属性标识， 对应html的id*/
    @JSONField(name = "ELEMENT_NAME")
    private String elementName = "detail_dynamic_table"; /*属性名称， 对应html的name*/
    @JSONField(name = "ELEMENT_TYPE")
    private String elementType = "9"; /*属性类型*/
    @JSONField(name = "ELEMENT_COLS")
    private String elementCol = "3"; /*TABLE 的总列数； 只有和 ELEMENT_LIST 并列的元素有效*/
    @JSONField(name = "ELEMENT_DIV_ATTR")
    private String elementDivAttr = "class=\"crm-data-lists\""; /*动态展示属性样式*/
    @JSONField(name = "ELEMENT_TABLE_ATTR")
    private String elementTableAttr;
    @JSONField(name = "ELEMENT_TR_ATTR")
    private String elementTrAttr;
    @JSONField(name = "ELEMENT_TD_ATTR")
    private String elementTdAttr;
    @JSONField(name = "ELEMENT_TD_LABEL_ATTR")
    private String elementTdLabelAttr;
    @JSONField(name = "ELEMENT_TD_LABEL_M_ATTR")
    private String elementTdLabelMAttr;
    @JSONField(name = "ELEMENT_PAGING")
    private boolean elementPaging;
    @JSONField(name = "ELEMENT_DATATOTAL")
    private String elementDataTotal;
    @JSONField(name = "ELEMENT_LABEL_TYPE")
    private String elementLabelType = "1";/* 表示是否有属性标签；1、有；2、无 */

    /*展示实际内容*/
    @JSONField(name = "ELEMENT_LIST")
    private List<ElementAttribute> elementAttrList = new ArrayList<ElementAttribute>();


    public static void main(String[] args) {
        DynamicTable dt = new DynamicTable();
        String json = JSON.toJSONString(dt);
        System.out.println(json);
    }

    public String getElementId() {
        return elementId;
    }

    public String getElementName() {
        return elementName;
    }

    public void setElementName(String elementName) {
        this.elementName = elementName;
    }

    public String getElementType() {
        return elementType;
    }

    public void setElementType(String elementType) {
        this.elementType = elementType;
    }

    public String getElementCol() {
        return elementCol;
    }

    public void setElementCol(String elementCol) {
        this.elementCol = elementCol;
    }

    public String getElementDivAttr() {
        return elementDivAttr;
    }

    public void setElementDivAttr(String elementDivAttr) {
        this.elementDivAttr = elementDivAttr;
    }

    public String getElementTableAttr() {
        return elementTableAttr;
    }

    public void setElementTableAttr(String elementTableAttr) {
        this.elementTableAttr = elementTableAttr;
    }

    public String getElementTrAttr() {
        return elementTrAttr;
    }

    public void setElementTrAttr(String elementTrAttr) {
        this.elementTrAttr = elementTrAttr;
    }

    public String getElementTdAttr() {
        return elementTdAttr;
    }

    public void setElementTdAttr(String elementTdAttr) {
        this.elementTdAttr = elementTdAttr;
    }

    public String getElementTdLabelAttr() {
        return elementTdLabelAttr;
    }

    public void setElementTdLabelAttr(String elementTdLabelAttr) {
        this.elementTdLabelAttr = elementTdLabelAttr;
    }

    public String getElementTdLabelMAttr() {
        return elementTdLabelMAttr;
    }

    public void setElementTdLabelMAttr(String elementTdLabelMAttr) {
        this.elementTdLabelMAttr = elementTdLabelMAttr;
    }

    public void setElementId(String elementId) {
        this.elementId = elementId;
    }

    public List<ElementAttribute> getElementAttrList() {
        return elementAttrList;
    }

    public void setElementAttrList(List<ElementAttribute> elementAttrList) {
        this.elementAttrList = elementAttrList;
    }

    public String getElementLabelType() {
        return elementLabelType;
    }

    public void setElementLabelType(String elementLabelType) {
        this.elementLabelType = elementLabelType;
    }

    public boolean isElementPaging() {
        return elementPaging;
    }

    public void setElementPaging(boolean elementPaging) {
        this.elementPaging = elementPaging;
    }

    public String getElementDataTotal() {
        return elementDataTotal;
    }

    public void setElementDataTotal(String elementDataTotal) {
        this.elementDataTotal = elementDataTotal;
    }

}
