(function() {
    var window = this,
    undefined, sitechJson = window.sitechJson = function(c) {
        return new sitechJson.p.init(c);
    },
    reg = (new RegExp()).compile("(\\w+)\\s*\\[(\\d+?)\\]"),
    regAttr = (new RegExp()).compile("^(\\w+[^[](?:\\[\\d+\\])*)\\[(>?\\w+)=([^=]+)\\]"),
    regSplit = (new RegExp()).compile("[./]*([^./]+)(?=[./])*", "g");

    //sitechJson instance body
    sitechJson.p = sitechJson.prototype = {
        version: 3.0,
        author: "yuguozhou",
        init: function(c) {
            var core = c;
            var context = core;;
            this._getContext = function() {
                return context;
            }
            this._getCore = function() {
                return core;
            }
            this._setContext = function(c) {
                context = c;
            }
            this._setCore = function(c) {
                core = c;
            }
        },
        find: function(selector) {
            var tempArr = [];
            var core = this._getCore();
            var context = this._getContext();
            if (!core) return sitechJson(null);
            var path = selector.split(".");
            if (!path || path.length == 0 || core.childNodes.length == 0) {
                this._setContext(core);
                return sitechJson(null);
            }
            var i = 0; 
            do {
                var regMatch = path[i].match(reg);
                path[i] = regMatch ? regMatch[1] : path[i];
                var arrayIndex = regMatch ? regMatch[2] : 0;
                var k = 0;
                if (!context.childNodes || !context.childNodes[k] || !context.childNodes[k].tagName) {
                    this._setContext(core);
                    return sitechJson(null);
                }

                do {

                    if (!arrayIndex && !arguments[1]) {
                        if (!arguments[2] && context.childNodes[k].tagName == path[i]) {
                            break;
                        } else if (arguments[2] && context.childNodes[k].tagName == path[i]) {
                            if (!path[i + 1]) {
                                context.childNodes[k].parent = context;
                                tempArr.push(context.childNodes[k]);
                            } else break;
                        }
                    } else if (arrayIndex) {
                        if (context.childNodes[k].tagName == path[i]) {
                            context.childNodes[k].parent = context;
                            tempArr.push(context.childNodes[k]);
                        }

                    } else if (!arrayIndex && arguments[1]) {
                        if (!arguments[2]) {
                            if (context.childNodes[k].tagName == path[i]) {
                                var innerJson = sitechJson(context.childNodes[k]);
                                if (arguments[1][2].charAt(0) == ">") {
                                    if (innerJson.deepFind("/" + arguments[1][2].slice(1)).value() == arguments[1][3]) {

                                        break;
                                    }
                                } else {
                                    if (innerJson.find(arguments[1][2]).value() == arguments[1][3]) {
                                        break;
                                    }
                                }

                            }
                        } else {
                            if (context.childNodes[k].tagName == path[i]) {
                                var innerJson = sitechJson(context.childNodes[k]);
                                if (arguments[1][2].charAt(0) == ">") { //遍历所有相同子节点?现在默认只有一个该类型的子节点，比如，product下面只有一个producttype节点，来定位子产品数组
                                    if (innerJson.deepFind("/" + arguments[1][2].slice(1)).value() == arguments[1][3]) {

                                        context.childNodes[k].parent = context;
                                        tempArr.push(context.childNodes[k]);
                                    }
                                } else {
                                    if (innerJson.find(arguments[1][2]).value() == arguments[1][3]) {
                                        context.childNodes[k].parent = context;
                                        tempArr.push(context.childNodes[k]);
                                    }
                                }

                            }
                        }
                    }

                } while ( typeof context . childNodes [++ k ] != "undefined") ;
                if (tempArr.length) {
                    if (arguments[2] && !path[i + 1]) {
                        this._setContext(core);
                        return tempArr;
                    } else {
                        if (typeof tempArr[arrayIndex] != "undefined") {
                            context = tempArr[arrayIndex];
                        } else {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                    }
                    tempArr = [];
                } else if (typeof context.childNodes[k] == "undefined") {
                    this._setContext(core);
                    return sitechJson(null);
                } else {
                    context.childNodes[k].parent = context;
                    context = context.childNodes[k];

                }

            } while ( typeof path [++ i ] != "undefined");

            this._setContext(core);
            return sitechJson(context);

        },
        deepFind: function(selector) {

            function search(c) {
                if (!c.tagName || !c.childNodes) return null;
                var tempArr = [];
                for (var l = 0; l < c.childNodes.length; l++) {

                    if (c.childNodes[l].tagName == path[i]) {
                        if (!arrayIndex1 && !arguments[1]) {
                            c.childNodes[l].parent = c;
                            return c.childNodes[l];
                        } else {
                            if (!arguments[2]) {
                                c.childNodes[l].parent = c;
                                tempArr.push(c.childNodes[l]);
                            } else {
                                var deepState = false;
                                var innerPath = null;
                                if (arguments[2][2].charAt(0) == ">") {
                                    deepState = true;
                                    innerPath = ("/" + arguments[2][2].slice(1))
                                }
                                if (deepState) {
                                    if (sitechJson(c.childNodes[l]).deepFind(innerPath).value() == arguments[2][3]) {
                                        c.childNodes[l].parent = c;
                                        tempArr.push(c.childNodes[l]);
                                    }
                                } else {
                                    var attrLen = c.childNodes[l] ? c.childNodes[l].childNodes.length: 0;
                                    for (var nin = 0; nin < attrLen; nin++) {

                                        if ((c.childNodes[l].childNodes[nin].tagName == arguments[2][2]) && (c.childNodes[l].childNodes[nin].childNodes && c.childNodes[l].childNodes[nin].childNodes[0] && (c.childNodes[l].childNodes[nin].childNodes[0] == arguments[2][3]))) {
                                            c.childNodes[l].parent = c;
                                            tempArr.push(c.childNodes[l]);
                                            break;
                                        }
                                    }
                                }

                            }
                        }
                    } else {
                        var inner = search(c.childNodes[l], !!arguments[1], arguments[2]);
                        if (inner && ((inner.length != undefined) ? !!inner.length: true)) {
                            return inner;
                        }
                    }
                }
                if (arguments[1]) return tempArr;
                if (typeof tempArr[arrayIndex1] != "undefined") {
                    return tempArr[arrayIndex1];
                } else {
                    return null
                } //此处算法会产生丢失情况，待改进
                return null;

            }
            var core = this._getCore();
            var context = this._getContext();
            var path = selector.match(regSplit);
            var tempArr = [];
            if (!core) return sitechJson(null);
            if (!path || path.length == 0 || core.childNodes.length == 0) {
                this._setContext(core);
                return sitechJson(null);
            }
            var i = 0;
            do {

                if (path[i].charAt(0) == "." || path[i].charAt(0) != "/") { (path[i].charAt(0) == ".") && (path[i] = path[i].slice(1));
                    var tempAttrArray = path[i].match(regAttr);
                    if (tempAttrArray) {
                        if (!path[i + 1] && arguments[1]) {
                            return this.find(tempAttrArray[1], tempAttrArray, true)
                        }
                        context = this.find(tempAttrArray[1], tempAttrArray)._getContext();

                        if (context == null) {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                        this._setContext(context);

                    } else {
                        if (!path[i + 1] && arguments[1]) {
                            return this.find(path[i], false, true)
                        }
                        context = this.find(path[i])._getContext();

                        if (context == null) {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                        this._setContext(context);
                    }

                } else {

                    path[i] = path[i].slice(1);
                    var tempAttrArray1 = path[i].match(regAttr);
                    if (tempAttrArray1) {
                        path[i] = tempAttrArray1[1];
                        var regMatch1 = path[i].match(reg);
                        path[i] = regMatch1 ? regMatch1[1] : path[i];
                        var arrayIndex1 = regMatch1 ? regMatch1[2] : 0;
                        if (!path[i + 1] && arguments[1]) {
                            ////////////////////////////////////////////////////
                            return search(context, true, tempAttrArray1)
                            ///////////////////////////////////////////////////
                        }
                        var deepState = false;

                        if (tempAttrArray1[2].charAt(0) == ">") {
                            deepState = true;
                            tempAttrArray1[2] = ("/" + tempAttrArray1[2].slice(1))
                        }
                        if (arrayIndex1) {
                            context = search(context);
                            if (!context) {
                                this._setContext(core);
                                return sitechJson(null);
                            }

                            if (deepState) {
                                //此处先不作子节点存在数组列表的情况
                                if (sitechJson(context).deepFind(tempAttrArray1[2]).value() == tempAttrArray1[3]) {

                                    this._setContext(context);
                                }
                            } else {
                                var attrLen = context ? context.childNodes.length: 0;
                                for (var nin = 0; nin < attrLen; nin++) {

                                    if ((context.childNodes[nin].tagName == tempAttrArray1[2]) && (context.childNodes[nin].childNodes && context.childNodes[nin].childNodes[0] && (context.childNodes[nin].childNodes[0] == tempAttrArray1[3]))) {
                                        //attrState = true;
                                        this._setContext(context);
                                        break;
                                    }
                                }
                            }
                            break;

                        }
                        var contextArr = search(context, true);
                        if (contextArr) {

                            for (var o = 0; o < contextArr.length; o++) {
                                context = contextArr[o];
                                var attrState = false;
                                if (deepState) {
                                    //此处先不作子节点存在数组列表的情况
                                    if (sitechJson(context).deepFind(tempAttrArray1[2]).value() == tempAttrArray1[3]) {

                                        attrState = true;
                                        this._setContext(context);
                                    }
                                } else {
                                    var attrLen = context ? context.childNodes.length: 0;
                                    for (var nin = 0; nin < attrLen; nin++) {

                                        if ((context.childNodes[nin].tagName == tempAttrArray1[2]) && (context.childNodes[nin].childNodes && context.childNodes[nin].childNodes[0] && (context.childNodes[nin].childNodes[0] == tempAttrArray1[3]))) {
                                            attrState = true;
                                            this._setContext(context);
                                            break;
                                        }
                                    }
                                }
                                if (attrState) {
                                    break;
                                }
                            }
                            if (!attrState) {
                                this._setContext(core);
                                return sitechJson(null);
                            }
                        } else {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                    } else {
                        var regMatch1 = path[i].match(reg);
                        path[i] = regMatch1 ? regMatch1[1] : path[i];
                        var arrayIndex1 = regMatch1 ? regMatch1[2] : 0;

                        context = search(context);
                        if (!context) {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                        this._setContext(context);
                    }

                }

            } while ( typeof path [++ i ] != "undefined");
            this._setContext(core);
            return sitechJson(context);
        },
        findArr: function(selector) {
            return new sitechJsonArr(this.find(selector, false, true));
        },
        dfindArr: function(selector) {
            return new sitechJsonArr(this.deepFind(selector, true));
        },
        value: function() {
            if (!this._getContext()) return "没有选择到节点，无返回值";
            return (this._getContext().type) ? (typeof this._getContext().childNodes != "undefined" ? this._getContext().childNodes[0] : "") : "节点类型，无返回值";

        },
        isNull: function() {
            return ! this._getContext();
        },
        set: function(v) {
            var context = this._getContext();
            if (context.type) {
                if (typeof context.childNodes == "undefined") {
                    context.childNodes = [];
                }
                context.childNodes[0] = v;
                return true;
            };
            return false;

        },

        addTag: function(value, tagName) {
            var context = this._getContext();
            for (var i = 0; i < context.childNodes.length; i++) {
                if (context.childNodes[i].tagName == tagName) {
                    var tempObj = {
                        "childNodes": [value],
                        "tagName": tagName,
                        "type": context.childNodes[i].type
                    };
                    tempObj.parent = context;
                    context.childNodes.push(tempObj);
                    return true;
                }
            }
            return false;
        },
        addValue: function(v) {
            if (typeof v != "number" || typeof v != "string") return false;
            var context = this._getContext();
            if (context.type) context.childNodes = [v];

        },
        addNode: function(obj) {
            if(obj&&obj._getContext)
            {
                var objContext = obj._getContext();
                var parentContext = this._getContext();
                if (typeof objContext.tagName != "undefined") {
                    if (typeof parentContext.childNodes == "undefined") parentContext.childNodes = [];
                    objContext.parent = parentContext;
                    parentContext.childNodes.push(objContext);
                    return true;
                }
            }
            return false;

        },
        remove: function() {
            var context = this._getContext();
            if (!context.parent) {
                alert("此节点没有挂接到任何节点，不能删除节点本身");
                return false;
            };
            if (!arguments[0]) {
                if (this.isNull() || context.parent.childNodes.length < 1) return false;
                for (var i = 0; i < context.parent.childNodes.length; i++) {
                    if (context.parent.childNodes[i] == context) {
                        context.parent.childNodes.splice(i, 1);
                        this._setContext(null);
                        return true;
                    }
                }

            } else {
                context.childNodes = [];
                return true
            }
            return false;
        },
        returnTagName: function() {
            var context = this._getContext();
            if (context) {
                return context.tagName
            } else {
                return "空节点，无tagName";
            }

        },
        returnType: function() {
            var context = this._getContext();
            if (context) {
                return context.type
            } else {
                return "空节点，无type";
            }

        },
        returnChildSum: function() {
            var context = this._getContext();
            if (context) {
                return context.childNodes ? context.childNodes.length: 0
            } else {
                return "空节点，无childNode";
            }

        },
        removeIndex: function(tName, index) {
            var context = this._getContext();
            var tempArr = [];
            for (var i = 0; i < context.childNodes.length; i++) {

                if (context.childNodes[i].tagName == tName) {
                    tempArr.push(i);
                }
                if ((tempArr.length > 0) && (index <= (tempArr.length - 1))) {
                    context.childNodes.splice(index, 1);
                    return true;
                }
            }
            return false;
        },
        toJson: function() {
            var _c = this._getCore();
            return toJSON(_c);
        }

        ,
        clone: function() {

            var context = this._getContext();
            var newContext = clone(context);
            return sitechJson(newContext);
        }

    }
    sitechJson.p.init.prototype = sitechJson.p;
    sitechJson.generateNode = function(tagName, childNode, type) {
        var arr = [];
        arr.push(childNode);
        if (type) {
            return sitechJson({
                "tagName": tagName,
                "type": type,
                "childNodes": arr
            }

            );
        } else {
            return sitechJson({
                "tagName": tagName,
                "childNodes": arr
            }

            );
        }
    };
    //unexposed class for array
    var sitechJsonArr = function(jsonarr) {
        if (jsonarr && jsonarr.length) this.arr = jsonarr;
        else this.arr = [];
    }
    sitechJsonArr.prototype = {
        get: function(num) {
            if (num < this.arr.length) return sitechJson(this.arr[num]);
            else return sitechJson(null)
        },
        remove: function(num) {
            if (num < this.arr.length) {
                var ele = this.arr[num];
                this.arr.splice(num, 1);
                return sitechJson(ele).remove();
            } else {
                return false
            }
        },
        //toJson:function(){},
        length: function() {
            return this.arr.length
        },
        isNull: function() {
            return ! this.arr.length
        },
        removeAll: function() {
            var ele;
            while (ele = this.arr.pop()) {
                if (!sitechJson(ele).remove()) return false;
            };
            return true;
        }

    };
    function clone(myObj) {
        if (typeof(myObj) != 'object') return myObj;
        if (myObj == null) return myObj;
        var myNewObj = {}; (Object.prototype.toString.apply(myObj) === '[object Array]') && (myNewObj = []);
        for (var i in myObj) {
            if (i != "parent" && myObj.hasOwnProperty(i)) {
                myNewObj[i] = clone(myObj[i]);
                myNewObj[i].parent = myNewObj;
            } else continue
        }

        return myNewObj;

    }
    //thanks to yuweiqiang for the following code which I merge into my sitechJson framework,see details in http://blog.csdn.net/yuweiqiang/archive/2009/07/03/4320140.aspx
    function toJSON(object) {
        var type = typeof object;
        if ('object' == type) {
            if (Array == object.constructor) type = 'array';
            else if (RegExp == object.constructor) type = 'regexp';
            else type = 'object';
        }
        switch (type) {
        case 'undefined':
        case 'unknown':
            return;
            break;
        case 'function':
        case 'boolean':
        case 'regexp':
            return object.toString();
            break;
        case 'number':
            return isFinite(object) ? object.toString() : 'null';
            break;
        case 'string':
            return '"' + object.replace(/(\\|\")/g, "\\$1").replace(/\n|\r|\t/g,
            function() {
                var a = arguments[0];
                return (a == '\n') ? '\\n': (a == '\r') ? '\\r': (a == '\t') ? '\\t': ""
            }) + '"';
            break;
        case 'object':
            if (object === null) return 'null';
            var results = [];
            for (var property in object) {
                if (property == "parent") continue;
                var value = toJSON(object[property]);
                if (value !== undefined) results.push(toJSON(property) + ':' + value);
            }
            return '{' + results.join(',') + '}';
            break;
        case 'array':
            var results = [];
            for (var i = 0; i < object.length; i++) {
                var value = toJSON(object[i]);
                if (value !== undefined) results.push(value);
            }
            return '[' + results.join(',') + ']';
            break;
        }
    }
})();


//----------------------------------------------------------------------------

var instanceTemplate={
CANCELINFO : function() {
	return sitechJson({
		"childNodes" : [{
				"childNodes" : [
				        {"type" : "int","tagName" : "BATCH_TYPE"},
						{"type" : "long","tagName" : "TEMPLATE_ID"},
						{"type" : "string","tagName" : "AUTO_CONFIRM"},
						{"type" : "string","tagName" : "BATCH_EXEC_TIME"}
					],
					"tagName" : "MSG_TYPE"
				} ,
		        {
					"childNodes" : [
					    {
					    	"childNodes":[
					    					{"type" : "string","tagName" : "LOGINACCEPT"},
					    					{"type" : "string","tagName" : "OLD_LOGINACCEPT"},
					    					{"type" : "string","tagName" : "CUSTORDERID"}, 
					    					{"type" : "string","tagName" : "ORDERARRAYID"},
					    					{"type" : "int","tagName" : "REGION_ID"},
					    					{"type" : "string","tagName" : "CHANNEL_TYPE"},
					    					{"type" : "string","tagName" : "LOGIN_NO"},
					    					{"type" : "string","tagName" : "LOGIN_PWD"},
					    					{"type" : "string","tagName" : "IP_ADDRESS"},
					    					{"type" : "string","tagName" : "GROUP_ID"},
					    					{"type" : "string","tagName" : "CONTACT_ID"},
					    					{"type" : "string","tagName" : "OP_CODE"},
					    					{"type" : "string","tagName" : "OP_NOTICE"},
					    					{"type" : "string","tagName" : "SYS_NOTE"},
					    					{"type" : "string","tagName" : "BRAND_ID"},
					    					{"type" : "long","tagName" : "CUST_ID"},
					    					{"type" : "long","tagName" : "ID_NO"},
					    					{"type" : "string","tagName" : "SERVICE_NO"},
					    					{"type" : "long","tagName" : "CONTRACT_NO"},
					    					{"type" : "string","tagName" : "IMPOWER_LOGIN"},
					    					{"type" : "string","tagName" : "MASTER_SERV_ID"},
					    					{"type" : "string","tagName" : "AUTHEN_CODE"},
					    					{"type" : "string","tagName" : "AUTHEN_NAME"},
					    					{"type" : "string","tagName" : "ACTION_TYPE"},
					    					{"type" : "string","tagName" : "ACTION_ID"},
					    					{"type" : "string","tagName" : "MEANS_ID"},
					    					{"type" : "string","tagName" : "OP_TIME"},
					    					{"type" : "string","tagName" : "BUY_ICCID"},
					    					{"type" : "string","tagName" : "BUY_NAME"},
					    					{"type" : "string","tagName" : "PRODPRC_NAME"},
					    					{"type" : "string","tagName" : "NOTE"}
					    				],
					    				"tagName":"OPR_INFO"
					    },
					    
					    {
					    	"childNodes":[
					    					{"type" : "string","tagName" : "ACTION_NAME"}, 
					    					{"type" : "string","tagName" : "CUST_NAME"}, 
					    					{"type" : "string","tagName" : "PHONE_NO"},
					    					{"type" : "string","tagName" : "PRINT_FLAG"},
					    					{"type" : "string","tagName" : "PAY_MONEYBIG"},
					    					{"type" : "string","tagName" : "PAY_MONEYSMALL"},
					    					{"type" : "string","tagName" : "PAY_SPECIALBIG"},
					    					{"type" : "string","tagName" : "PAY_SPECIALSMALL"},
					    					{"type" : "string","tagName" : "RESOURCEBRAND"},
					    					{"type" : "string","tagName" : "RESOURCE_MODEL"},
					    					{"type" : "string","tagName" : "IMEI_CODE"},
					    					{"type" : "string","tagName" : "LOGIN_NAME"}
					    				],
					    				"tagName":"PRINT_INFO"
					    },
					    
					    {
							//"childNodes" : [{
									//"tagName" : "BUSIINFO"
								//}
						//	],
							"tagName" : "BUSIINFO_LIST"
						} ],
			"tagName" : "REQUEST_INFO"
		}],
		"tagName" : "ROOT"
	})
},

PRODPRC_BUSIINFO:function(){
	return sitechJson(
			{"childNodes" : [
				{"type" : "string","tagName" : "BUSIINFO_SEQ"}, 
				{"type" : "long","tagName" : "SERVICE_OFFER_ID"},
				{"type" : "string","tagName" : "DOMAIN_TYPE"},
				{"type" : "string","tagName" : "PHONE_NO"},
				{"type" : "long","tagName" : "ID_NO"},
				{"type" : "long","tagName" : "CUST_ID"},
				{"type" : "string","tagName" : "BRAND_ID"},
				{"type" : "string","tagName" : "GROUP_ID"},
				//{"tagName" : "ORDER_LINE_FEELIST"},
			    {
					"childNodes" : [ {
						/*"childNodes" : [ {
							
							"tagName" : "PRODPRC"
						} ],*/
						"tagName" : "PRODPRC_LIST"
					} ],
					"tagName" : "BUSI_MODEL"
				} ],
				"tagName":"BUSIINFO"
			}
		)
},

RES_BUSIINFO:function(){
	return sitechJson(
			{"childNodes" : [
				{"type" : "string","tagName" : "BUSIINFO_SEQ"}, 
				{"type" : "long","tagName" : "SERVICE_OFFER_ID"},
				{"type" : "string","tagName" : "DOMAIN_TYPE"},
				{"type" : "string","tagName" : "PHONE_NO"},
				{"type" : "long","tagName" : "ID_NO"},
				{"type" : "long","tagName" : "CUST_ID"},
				{"type" : "string","tagName" : "BRAND_ID"},
				{"type" : "string","tagName" : "GROUP_ID"},
				//{"tagName" : "ORDER_LINE_FEELIST"},
			    {
					"childNodes" : [ {
						/*"childNodes" : [ {
							
							"tagName" : "PRODPRC"
						} ],*/
						"tagName" : "RES_INFO_LIST"
					} ],
					"tagName" : "BUSI_MODEL"
				} ],
				"tagName":"BUSIINFO"
			}
		)
},

SCORE_BUSIINFO:function(){
	return sitechJson(
			{"childNodes" : [
				{"type" : "string","tagName" : "BUSIINFO_SEQ"}, 
				{"type" : "long","tagName" : "SERVICE_OFFER_ID"},
				{"type" : "string","tagName" : "DOMAIN_TYPE"},
				{"type" : "string","tagName" : "PHONE_NO"},
				{"type" : "long","tagName" : "ID_NO"},
				{"type" : "long","tagName" : "CUST_ID"},
				{"type" : "string","tagName" : "BRAND_ID"},
				{"type" : "string","tagName" : "GROUP_ID"},
				//{"tagName" : "ORDER_LINE_FEELIST"},
			    {
					"childNodes" : [ {
						/*"childNodes" : [ {
							
							"tagName" : "PRODPRC"
						} ],*/
						"tagName" : "DEDUCTION_INTEGRAL_BUSI_LIST"
					} ],
					"tagName" : "BUSI_MODEL"
				} ],
				"tagName":"BUSIINFO"
			}
		)
},

FEE_BUSIINFO:function(){
	return sitechJson(
			{"childNodes" : 
				[
						{"type" : "string","tagName" : "BUSIINFO_SEQ"}, 
						{"type" : "long","tagName" : "SERVICE_OFFER_ID"},
						{"type" : "string","tagName" : "DOMAIN_TYPE"},
						{"type" : "string","tagName" : "PHONE_NO"},
						{"type" : "long","tagName" : "ID_NO"},
						{"type" : "long","tagName" : "CUST_ID"},
						{"type" : "string","tagName" : "BRAND_ID"},
						{"type" : "string","tagName" : "GROUP_ID"},
						{"type" : "string","tagName" : "MARKET_PRICE"},
						{"type" : "string","tagName" : "TAX_PERCENT"},
						{"type" : "string","tagName" : "TAX_FEE"},
						//{"tagName" : "ORDER_LINE_FEELIST"},
						{
							//"childNodes" : [ {
								/*"childNodes" : [ {
									"tagName" : "ORDER_LINE_FEE"
								} ],*/
								"tagName" : "ORDER_LINE_FEELIST"
							//} ],
							//"tagName" : "BUSI_MODEL"
						} 
					],
						"tagName" : "BUSIINFO"
			}
		)
},


DATA_LIST_BUSIINFO:function(){
	return sitechJson(
			{"childNodes" : [
				{"type" : "string","tagName" : "BUSIINFO_SEQ"}, 
				{"type" : "long","tagName" : "SERVICE_OFFER_ID"},
				{"type" : "string","tagName" : "DOMAIN_TYPE"},
				{"type" : "string","tagName" : "PHONE_NO"},
				{"type" : "long","tagName" : "ID_NO"},
				{"type" : "long","tagName" : "CUST_ID"},
				{"type" : "string","tagName" : "BRAND_ID"},
				{"type" : "string","tagName" : "GROUP_ID"},
				//{"tagName" : "ORDER_LINE_FEELIST"},
			    {
					/*"childNodes" : [ {
						"tagName" : "DATA_LIST"
					} ],*/
					"tagName" : "BUSI_MODEL"
				}
				],
				"tagName":"BUSIINFO"
			}
		)
},

DATA_LIST_INFO:function(){
		return sitechJson(
			{"childNodes":
				[
					{"type":"string","tagName":"RESOURCE_MONTH_PAY"},
					{"type":"string","tagName":"RESOURCE_UNDEADLINE"},
					{"type":"string","tagName":"CHK_LENGTH"},
					{"type":"string","tagName":"FAM_TYPE_CODE"},
					{"type":"string","tagName":"FAM_PROD_CODE"},
					{"type":"string","tagName":"COMP_CODE"},
					{"type":"string","tagName":"BUSI_CODE"},
					{"type":"string","tagName":"EFF_TYPE"},
					{"type":"string","tagName":"EFF_TIME"},
					{"type":"string","tagName":"EXP_TIME"},

					{"type" : "string","tagName" : "SCORE_VALUE"},
					{"type" : "string","tagName" : "GIFT_CODE"},
					{"type" : "string","tagName" : "PLANT_FLAG"}
				],
				"tagName":"DATA_LIST"
			}
		)
},
GSP_INFO:function(){
	return sitechJson(
			{"childNodes":
				[
				 	{"type":"string","tagName" : "GSP_STR"}
				],
				"tagName":"GSP_INFO"
			}
		)
			
},

SP_INFO:function(){
	return sitechJson(
			{"childNodes":
				[
				 	{"type":"string","tagName" : "SP_CODE"},
				 	{"type":"string","tagName" : "BUSI_CODE"},
				 	{"type":"string","tagName" : "START_DATE"},
				 	{"type":"string","tagName" : "END_DATE"},
				 	{"type":"string","tagName":"BOX_ID"}
				],
				"tagName":"SP_INFO"
			}
		)
			
},
ORDER_LINE_FEE_INFO:function(){
	return sitechJson(
			{"childNodes":
				[
					{"type":"string","tagName":"RECEIVE_FEE_TYPE"},
					{"type":"string","tagName":"RECEIVE_ACC_TYPE"},
					{"type":"string","tagName":"FEE_TYPE"},
					{"type":"string","tagName":"FEE_CODE"},
					{"type":"string","tagName":"FACTOR_ONE"},
					{"type":"string","tagName":"FACTOR_TWO"},
					{"type":"string","tagName":"FACTOR_THREE"},
					{"type":"string","tagName":"FACTOR_FOUR"},
					{"type":"string","tagName":"FACTOR_FIVE"},
					{"type":"string","tagName":"FACTOR_SIX"},
					{"type":"string","tagName":"FACTOR_SEVEN"},
					{"type":"string","tagName":"FACTOR_EIGHT"},
					{"type":"string","tagName":"FACTOR_NINE"},
					{"type":"string","tagName":"FACTOR_TEN"},
					{"type":"string","tagName":"FACTOR_ELEVEN"},
					{"type":"string","tagName":"FACTOR_TWELVE"},
					{"type":"string","tagName":"FACTOR_THIRTEEN"},
					{"type":"string","tagName":"FACTOR_FOURTEEN"},
					{"type":"string","tagName":"FACTOR_FIFTEEN"},
					{"type":"string","tagName":"FACTOR_SIXTEEN"},
					{"type":"string","tagName":"FACTOR_SEVENTEEN"},
					{"type":"string","tagName":"FACTOR_EIGHTEEN"},
					{"type":"string","tagName":"FACTOR_NINETEEN"},
					{"type":"string","tagName":"FACTOR_TWENTY"},
					{"type":"string","tagName":"FACTOR_TWENTYONE"},
					{"type":"string","tagName":"FACTOR_TWENTYTWO"},
					{"type":"string","tagName":"FACTOR_TWENTYTHREE"},
					{"type":"string","tagName":"FACTOR_TWENTYFOUR"},
					{"type":"string","tagName":"FACTOR_TWENTYFIVE"},
					{"type":"string","tagName":"FACTOR_TWENTYFSIX"},
					{"type":"string","tagName":"FACTOR_TWENTYFSEVEN"},
					{"type":"string","tagName":"FACTOR_TWENTYFEIGHT"},
					{"type":"string","tagName":"FACTOR_TWENTYFNINE"},
					{"type":"string","tagName":"FACTOR_THRITY"},
					{"type":"long","tagName":"SHOULD_PAY"},
					{"type":"long","tagName":"BUSI_SHOULD"}
				],
				"tagName":"ORDER_LINE_FEE"
			}
		)
	},

	
	PRODPRC_INFO:function(){
		return sitechJson(
			{"childNodes":
				[
					{"type":"string","tagName":"OPERATE_TYPE"},
					{"type":"string","tagName":"DISCOUNTPLANINSTID"},
					{"type":"string","tagName":"ORDER"},
					{"type":"string","tagName":"CUSTAGREEMENTID"},
					{"type":"string","tagName":"STATUS"},
					{"type":"string","tagName":"PEI_FEE_CODE"},
					{"type":"string","tagName":"PEI_FEE_NAME"},
					{"type":"string","tagName":"PRI_FEE_VALID"},
					{"type":"string","tagName":"DISTRI_FEE_NAME"},
					{"type":"string","tagName":"DISTRI_FEE_CODE"},
					{"type":"string","tagName":"KX_HABITUS_BUNCH"},
					{"type":"string","tagName":"EFF_DATE"},
					{"type":"string","tagName":"EXP_DATE"},
					{"type":"string","tagName":"PARENTINSTID"},
					{"type":"string","tagName":"CURLEVEL"},
					{"type":"string","tagName":"DEVELOP_NO"},
					{"type":"string","tagName":"FACTOR_ONE"},
					{"type":"string","tagName":"FACTOR_TWO"},
					{"type":"string","tagName":"FACTOR_THREE"},
					{"type":"string","tagName":"FACTOR_FOUR"},
					{"type":"string","tagName":"FACTOR_FIVE"}
				],
				"tagName":"PRODPRC"
			}
		)
	},
	
	RES_INFO:function(){
		return sitechJson(
			{"childNodes":
				[
					{"type":"string","tagName":"SALE_NOTE"},
					{"type":"string","tagName":"RES_COST_FEE"},
					{"type":"string","tagName":"RES_SALE_FEE"},
					{"type":"string","tagName":"RES_REAL_FEE"},
					{"type":"string","tagName":"MOB_ALLOWANCE"},
					{"type":"string","tagName":"TT_ALLOWANCE"},
					{"type":"string","tagName":"RESOURCE_BRAND"},
					{"type":"string","tagName":"RESOURCE_MODEL"},
					{"type":"string","tagName":"RESOURCE_RES_CODE"},
					{"type":"string","tagName":"RESOURCE_BRAND_CODE"},
					{"type":"string","tagName":"IMEI_CODE"},
					{"type":"string","tagName":"DELIVERY_TIME"},
					{"type":"string","tagName":"QUALITY_LIMIT"},
					{"type":"string","tagName":"RESOURCE_UNDEADLINE"},
					{"type":"string","tagName":"RESOURCE_PERCENT"},
					{"type":"string","tagName":"RESOURCE_MONTH_PAY"},
					{"type":"string","tagName":"ISSUE_TYPE"},
					{"type":"string","tagName":"IS_AWARD"},
					{"type":"string","tagName":"CHK_LENGTH"},
					{"type":"string","tagName":"GIFT_MODEL"},
					{"type":"string","tagName":"GIFT_NO"},
					{"type":"string","tagName":"GIFT_NAME"},
					{"type":"string","tagName":"GIFT_SOURCE"},
					{"type":"string","tagName":"GIFT_PRICE"},
					{"type":"string","tagName":"SALE_CODE"},
					{"type":"string","tagName":"RES_BUSI_TYPE"},
					{"type":"string","tagName":"SUPPLIER_NAME"},
					{"type":"string","tagName":"SUPPLIER_CODE"},
					{"type":"string","tagName":"RESOURCE_TYPE"},
					{"type":"string","tagName":"UPDATE_NO"}
				],
				"tagName":"RES_INFO"
			}
		)
	},
	
	DEDUCTION_INTEGRAL_BUSI_INFO:function(){
		return sitechJson(
			{"childNodes":
				[
					{"type":"string","tagName":"SCORE_TYPE"},
					{"type":"string","tagName":"SCORE_VALUE"},
					{"type":"string","tagName":"RES_NUM"},
					{"type":"string","tagName":"CON_MONEY"},
					{"type":"string","tagName":"FACTOR_ONE"},
					{"type":"string","tagName":"FACTOR_TWO"},
					{"type":"string","tagName":"FACTOR_THREE"},
					{"type":"string","tagName":"FACTOR_FOUR"},
					{"type":"string","tagName":"FACTOR_FIVE"}
				],
				"tagName":"DEDUCTION_INTEGRAL_BUSI_INFO"
			}
		)
	},

ROOT : function() {
	return sitechJson({
		"childNodes" : [ {
			"childNodes" : [ {
				"type" : "int",
				"tagName" : "BATCH_TYPE"
			}, {
				"type" : "long",
				"tagName" : "TEMPLATE_ID"
			} ],
			"tagName" : "MSG_TYPE"
		}, {
			"childNodes" : [ {
				"childNodes" : [ {
					"type" : "int",
					"tagName" : "REGION_ID"
				}, {
					"type" : "string",
					"tagName" : "CHANNEL_TYPE"
				}, {
					"type" : "string",
					"tagName" : "LOGIN_NO"
				}, {
					"type" : "string",
					"tagName" : "LOGIN_PWD"
				}, {
					"type" : "string",
					"tagName" : "IP_ADDRESS"
				}, {
					"type" : "string",
					"tagName" : "GROUP_ID"
				}, {
					"type" : "long",
					"tagName" : "CONTACT_ID"
				}, {
					"type" : "string",
					"tagName" : "OP_CODE"
				}, {
					"type" : "string",
					"tagName" : "OP_NOTE"
				}, {
					"type" : "string",
					"tagName" : "SYS_NOTE"
				}, {
					"type" : "long",
					"tagName" : "CUST_ID"
				}, {
					"type" : "long",
					"tagName" : "ID_NO"
				}, {
					"type" : "string",
					"tagName" : "SERVICE_NO"
				}, {
					"type" : "long",
					"tagName" : "CONTRACT_NO"
				} ],
				"tagName" : "OPR_INFO"
			}, {
				"childNodes" : [ {
					"childNodes" : [ {
						"type" : "long",
						"tagName" : "BUSI_TYPE_ID"
					} ],
					"tagName" : "ORDER_INFO"
				} ],
				"tagName" : "BUSIINFO_LIST"
			} ],
			"tagName" : "REQUEST_INFO"
		} ],
		"tagName" : "ROOT"
	})
}





}

var pushValue = {
		ROOT : function() {

		},
		CANCELINFO : function() {

		},
		PRODPRC_INFO : function() {

		},
		ORDER_LINE_FEE_INFO : function(){
			
		},
		FEE_BUSIINFO:function(){
			
		},
		PRODPRC_BUSIINFO:function(){
			
		},
		DATA_LIST_INFO:function(){
			
		},
		DATA_LIST_BUSIINFO:function(){
			
		}
	}