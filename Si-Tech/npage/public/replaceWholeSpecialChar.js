function replaceWholeSpecialChar(specialObj){
  var newStr = "";
  newStr = specialObj.replace(/\,/g, "��").replace(/%/g, "��").replace(/\+/g, "��");
  newStr = newStr.replace(/\=/g, "��").replace(/\|/g, "��").replace(/#/g, "��");
  newStr = newStr.replace(/\!/g, "��").replace(/\./g, "��");
  newStr = newStr.replace(/\$/g, "��").replace(/\?/g, "��").replace(/\-/g, "��");
  newStr = newStr.replace(/\</g, "��").replace(/\>/g, "��").replace(/\;/g, "��");
  newStr = newStr.replace(/\{/g, "��").replace(/\{/g, "��").replace(/\\/g, "��");
  newStr = newStr.replace(/\//g, "��");
  return newStr;
}