function replaceWholeSpecialChar(specialObj){
  var newStr = "";
  newStr = specialObj.replace(/\,/g, "£¬").replace(/%/g, "£¥").replace(/\+/g, "£«");
  newStr = newStr.replace(/\=/g, "£½").replace(/\|/g, "£ü").replace(/#/g, "££");
  newStr = newStr.replace(/\!/g, "£¡").replace(/\./g, "¡£");
  newStr = newStr.replace(/\$/g, "£¤").replace(/\?/g, "£¿").replace(/\-/g, "£­");
  newStr = newStr.replace(/\</g, "¡¶").replace(/\>/g, "¡·").replace(/\;/g, "£»");
  newStr = newStr.replace(/\{/g, "£û").replace(/\{/g, "£ý").replace(/\\/g, "¡¢");
  newStr = newStr.replace(/\//g, "¡¢");
  return newStr;
}