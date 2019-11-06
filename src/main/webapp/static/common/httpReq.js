document.write("<script language=javascript src='static/jQuery/jquery-3.4.1.min.js'></script>");
document.write("<script language=javascript src='static/layui/layui.js'></script>");

var user = {
    defaultUrl:'http://localhost:9011'
}

var myurl = {

}

var req = {
    post: function (url,data,async) {
        r = null;
        $.ajax({
            url: user.defaultUrl + url,
            type: 'POST',
            data: JSON.stringify(data),
            dataType: 'json',
            contentType: 'application/json',
            async: async == null ? false : async,
            success: function(data){
                r = data;
            }
        })
        if(r == null)
        {
            r == '404:数据请求失败'
        }
        return r;
    }
}

var common = {
    //text语法
    //id(id标识名):{
    //      title:该行的名字
    //      type:text，
    //      verify:lay-verify的值，如果是required就是必填项
    // }

    //radio语法
    //id(id标识名):{
    //      title:该行的名字,
    //      type:radio
    //      value:[]数组，与radioTitle一一对应
    //      radioTitle:[]数组，与value一一对应
    // }

    //select语法
    //id(id标识名):{
    //      title:该行的名字,
    //      type:select
    //      data:{}json key(显示的行)-value(option中value的值)
    //      radioTitle:[]数组，与value一一对应
    //      verify:lay-verify的值，如果是required就是必填项
    // }
    form: data => {
    $('#' + data.form).empty()
    for(let key in data)
    {
        let myId = data.form + "_" + key
        switch (data[key].type) {
            case 'text':{
                $('#' + data.form).append("<div class='layui-form-item'>\n" +
                    "<label class='layui-form-label'>"+ data[key].title +"</label>\n" +
                    "<div class='layui-input-inline '>\n" +
                    "<input type='"+ data[key].type +"' id='"+  myId +"' name='" + key + "' " +
                    "lay-verify='"+ data[key].verify +"' autocomplete='off' "+ (data[key].verify == "required" ? "required" : "") +"\n" +
                    "class='layui-input'/>" +
                    "</div>\n" + "</div>\n")
                break;
            }
            case 'radio':{
                $('#' + data.form).append("<div class='layui-form-item'>\n" +
                    "<label class='layui-form-label'>"+ data[key].title +"</label>\n" +
                    "<div class='layui-input-block' id='myRadio-"+  myId +"'>\n" +
                    "</div>\n" + "</div>\n")
                for(let i = 0; i < data[key].value.length; i++)
                {
                    $('#myRadio-'+  myId).append("<input type='"+ data[key].type +"' name='" + key + "' value='"+ data[key].value[i] +"' id='"+  data.form + "_" + key +"' title='" + data[key].radioTitle[i] + "'/>\n")
                }
                break;
            }
            case 'select':{
                $('#' + data.form).append("<div class='layui-form-item'>\n" +
                    "<label class='layui-form-label'>"+ data[key].title +"</label>\n" +
                    "<div class='layui-input-inline '>\n" +
                    "<select id='"+  myId +"' name='" + key + "' lay-verify='" + data[key].verify + "'></select>" +
                    "</div>\n" + "</div>\n")
                for(let key2 in data[key].data)
                {
                    $('#' + myId).append("<option value='" + key2 + "'>" + data[key].data[key2] + "</option>")

                }
                break;
            }
        }
        $('#' + myId).addClass(data[key].class)
        if(data[key].disable == true)
            $('#' + myId).attr('disabled', "")
    }
    $('#' + data.form).append("<div class='layui-form-item'>\n" +
        "<button id='Yes' style='position: absolute; margin-left:80px; margin-bottom: 15px;' class='layui-btn' lay-submit \n" +
        "lay-filter='" + data.button.submitFilter + "' onclick='" + data.button.submitClick + "'>" + data.button.submit + "</button>\n" +
        "<button id='No' type='button' style='position: absolute; margin-left:360px; margin-bottom: 15px; background:red' class='layui-btn' onclick='" + data.button.backClick + "'>" + data.button.back + "</button>\n" +
        "</div>")
    form.render()
    },

    reload:(id, data) => {
        table.reload(id, {
            page:{
                curr:1
            },
            where:data,
        })
    },

    // 使用语法:
    // common.timeline(ul的id,{
    //     title:日期,
    //     text:显示内容
    // })每次增加一条
    timeline: (id, data) =>{
        $('#' + id).append("  <li class=\"layui-timeline-item\">\n" +
            "    <i class=\"layui-icon layui-timeline-axis\">&#xe63f;</i>\n" +
            "    <div class=\"layui-timeline-content layui-text\">\n" +
            "      <h3 class=\"layui-timeline-title\">"+ data.title +"</h3>\n" +
            "      <p>\n" +
                    data.text +
            "      </p>\n" +
            "    </div>\n" +
            "  </li>")
    }

}
