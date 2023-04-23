
function isValidUsername (str) {
  return ['admin', 'editor'].indexOf(str.trim()) >= 0;
}

function isExternal (path) {
  return /^(https?:|mailto:|tel:)/.test(path);
}

function isCellPhone (val) {
  if (!/^1(3|4|5|6|7|8)\d{9}$/.test(val)) {
    return false
  } else {
    return true
  }
}

//Verify Account
function checkUserName (rule, value, callback){
  if (value == "") {
    callback(new Error("Please input Username"))
  } else if (value.length > 20 || value.length <3) {
    callback(new Error("Account length should be 3-20"))
  } else {
    callback()
  }
}

//Verify name
function checkName (rule, value, callback){
  if (value == "") {
    callback(new Error("Please type in your name"))
  } else if (value.length > 12) {
    callback(new Error("Account length should be 1-12"))
  } else {
    callback()
  }
}

function checkPhone (rule, value, callback){
  // let phoneReg = /(^1[3|4|5|6|7|8|9]\d{9}$)|(^09\d{8}$)/;
  if (value == "") {
    callback(new Error("Please enter phone number"))
  } else if (!isCellPhone(value)) {//Introduce the method of checking the mobile phone format encapsulated in methods
    callback(new Error("please enter a valid phone number!"))
  } else {
    callback()
  }
}


function validID (rule,value,callback) {
  /*
    The ID card number is 15 or 18 digits.
    When 15 digits are all numbers,
    the first 17 digits of the 18 digits are numbers,
    and the last digit is a check digit, which may be a number or character X
   */
  let reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/
  if(value == '') {
    callback(new Error('Please enter ID number'))
  } else if (reg.test(value)) {
    callback()
  } else {
    callback(new Error('ID number is incorrect'))
  }
}