function showModifyWarning(text){ 
    var warning = document.getElementById('warning');
    warning.innerText = text;
    warning.style.display = "inline-block"; 
}
function hideModifyWarning(){ 
    warning.style.display = "none"; 
}

function activeModifyButton(){ 
    var button = document.getElementById('confirm');
    button.disabled = null; 
    button.value = "下一步";
}
function deactiveModifyButton(){ 
    var button = document.getElementById('confirm');
    button.disabled = "disabled"; 
    button.value = "正在提交请求……"
}

function checkModifyForm(){ 
    var nickname = document.getElementById('nickname');
    var password = document.getElementById('password');
    var new_password = document.getElementById('new_password');
    var confirm_password= document.getElementById('confirm_password');
    var md5_password= document.getElementById('md5_password');
    var md5_new_password= document.getElementById('md5_new_password');
    if(nickname.value == ""){
        if(password.value == "" && new_password.value == "" && confirm_password.value == ""){
            showModifyWarning("请输入需要更改的条目");
            return false;
        }
        if(password.value == ""){
            showModifyWarning("当前密码不能为空");
            return false;
        }
        if(new_password.value == ""){
            showModifyWarning("新密码不能为空");
            return false;
        }
        if(new_password.value !== confirm_password.value){
            showModifyWarning("两次输入的新密码不一致");
            return false;
        }
    }else{
        if(password.value != "" || new_password.value != "" || confirm_password.value != ""){
            if(password.value == ""){
                showModifyWarning("当前密码不能为空");
                return false;
            }
            if(new_password.value == ""){
                showModifyWarning("新密码不能为空");
                return false;
            }
            if(new_password.value !== confirm_password.value){
                showModifyWarning("两次输入的新密码不一致");
                return false;
            }
        }
    }
    hideModifyWarning();
    deactiveModifyButton();
    if(password.value !== "")
        md5_password.value = hex_md5(password.value);          
    if(new_password.value !== "")
        md5_new_password.value = hex_md5(new_password.value);          
    return true;
}

$("iframe[name=modifyBackContent]").on("load", function() {
    var responseText = $("iframe")[0].contentDocument.body.getElementsByTagName("pre")[0].innerHTML; 
    var json = JSON.parse(responseText);
    showModifyWarning(json.err_msg);
    activeModifyButton();
    checkLogin();
}) 

function postEvent(url, parameters, after, error){
    var xhr = new XMLHttpRequest();
    xhr.open('POST', url);
    xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
    xhr.onload = function() {
        if (xhr.status < 400) {
            var json = JSON.parse(xhr.responseText);
            after.call(xhr, json);
        }
    };
    xhr.onerror = function() {
        error.call(xhr, xhr);
    };
    xhr.send(parameters);
}

function getCookies(){
    var cookieObj = {};
    var temp = [];
    var cookies = document.cookie.split(";");
    for(var i = 0; i < cookies.length;i++){
        if(cookies[i]) {
            temp = cookies[i].split("=");
            cookieObj[temp[0].trim()] = temp[1].trim();
        }
    }
    return cookieObj;
}

function logout(){
    var cookies = getCookies();
    if(cookies.username){
        postEvent('./logout.do', 'username=' + cookies.username, function(json){
            if(json.err_code == 0){
                window.location.href = "./login.jsp";
            }
        }, function(json){});
    }
}