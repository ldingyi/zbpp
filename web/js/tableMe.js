;(function($,window,document,undefined){
    function Table(element,options){
        this.element = element;
        this.options = {
            title:options.title,//表头
            id:options.id,//id
            size:options.size,//每一页的大小
            search:options.search,//查询 传递
            addBtn:options.addBtn,//添加按钮
            divbutton:options.divbutton,//点击div
            deleteCallback:options.deleteCallback,//删除回调
            sendCallback:options.sendCallback,//发送消息回调
            searchCallback:options.searchCallback//查询回调
        };



    }
    Table.prototype = {
        constructor:Table,
        checkboxArray:[],
        /*ids:[],*/
        chooseFlag:0,
        isall:0,
        allExcept:[],
        init:function(){
            this.createHtml();
            this.bindEvent();
        },

        createHtml:function(){
            var me = this;
            var title = me.options.title;
            var size = me.options.size;
            var search = me.options.search;
            var id = me.options.id;

            //遮罩层，添加的body里面
            var shade = $("<div class= 'shade' id='shade'></div>");

            //anv 上面的功能选项栏
            var nav = $("<div class='nav'>" +
                            "<ul>" +
                                "<li><button class='navbar' id='add'></button></li>" +
                                "<li><button class='navbar' id='search'></button></li>" +
                                "<li><button class='navbar' id='choose'></button></li>" +
                            "</ul>" +
                        "</div>");

            //info 内容区域 包括查询和主题信息
            var info = $("<div class='info'></div>");

                //search的内容
                var search = $("<div class='search' id='searchbox'></div>");
                    //search的关闭按钮
                    var searchclose = $("<div class='close'>" +
                                        "<button id='close'></button>" +
                                   "</div>");

                    //search的内容 交个用户定义，添加到searchbody
                        var searchbody = $("#"+me.options.search);





                    //search的功能按钮
                    var searchfun= $("<div class='searchfun'>" +
                                                "<button id='dosearch'>确认</button>" +
                                                "<button id='reset'>重置</button>" +
                                        "</div>");
                //assemble search and add search to document
                search.append(searchclose).append(searchbody).append(searchfun);
                info.append(search);


                //thead
                var thead = $("<div class='thead'></div>");
                    var headUl = $("<ul></ul>");
                    for (var i = 0;i<me.options.title.length;i++){
                        var headLi = $("<li></li>").append(me.options.title[i].name);
                        headUl.append(headLi);
                    }
                    thead.append(headUl);
                //add thead to document
                info.append(thead);




                //下面的功能栏，
                var fun = $("<div class='fun'>" +
                                "<ul id='funul'>" +
                                    "<li>" +
                                        "<button class='function' id='all'></button>" +
                                        "<span id='allspan'>全选</span>" +
                                    "</li>" +
                                    "<li>" +
                                        "<button class='function' id='delete'></button>" +
                                        "<span>删除</span>" +
                                    "</li>" +
                                    "<li>" +
                                        "<button class='function' id='send'></button>" +
                                        "<span>通知</span>" +
                                    "</li>" +
                                "</ul>" +
                            "</div>");



                 //添加到文档中
                $("body").prepend(shade);

                me.element.append(nav).append(info).append(fun);



        },
        bindEvent:function(){
            var me = this;
            //choose click
            $("#choose").click(function(){
                choose();
            });




            //close click
            $("#close").click(function () {
                $("#shade").css("display","none");
                $("#searchbox").animate({
                    width : '0'
                },200);
                $("#searchbox").css({
                    border: 'none'
                });
            });

            // search click
            $("#search").click(function () {
                $("#shade").css("display","block");
                $("#searchbox").animate({
                    width : '30%'
                },200);
                $("#searchbox").css({
                    border: '3px solid chocolate'
                });

            });


            //all click
            $("#all").click(function () {
                allOrNo();
            });






           //choose many
            function choose(){
                if(me.chooseFlag==0){
                    openChoose();
                }else {
                    closeChoose();
                    allnoChoose();
                    me.isall=0;
                }
            }


           function openChoose(){
               me.chooseFlag=1;
               $(".checkbox").css("display","flex");
               $(".tdata").off('click');
               $("#funul").css("display","inline");
           }

           function closeChoose() {
               me.chooseFlag=0;
               $(".checkbox").css("display","none");
               $(".tdata").on('click',function () {
                   var id = $(this).find('input[type=checkbox]').val();
                   if(me.options.divbutton){
                       me.options.divbutton(id);
                   }
               });
               $("#funul").css("display","none");
           }



            //all checked button
            function allOrNo(){
                if (me.isall==0){
                    allChoose();
                    me.isall=1;
                } else {
                    allnoChoose();
                    me.isall=0;
                }
            }





            //check all
            function allChoose() {
                /*所有checked选中*/
                $("input[type=checkbox]").prop("checked",true);
               /* /!*数组中没有的id放进数组*!/

                    me.checkboxArray=me.ids;
                    */
                /*改变全选按钮*/
                me.checkboxArray=[];
                me.allExcept=[];
                $("#all").css("background","url('images/tableMe/all.png')");
                $("#allspan").text("全不选");
            }

            //all no
            function allnoChoose(){
                /*所有checkbox不选中*/
                $("input[type=checkbox]").prop("checked",false);
               /* me.checkboxArray=[];*/
                /*改变全选按钮*/


                me.allExcept=[];
                me.checkboxArray=[];
                $("#all").css("background","url('images/tableMe/allno.png')");
                $("#allspan").text("全选");

            }

            //addBtn callback
            $("#add").click(function () {
                if(me.options.addBtn){
                    if (me.isall==0) {
                        me.options.addBtn(me.checkboxArray,me.isall);
                    }else{
                        me.options.addBtn(me.allExcept,me.isall)
                    }
                }
            });

            //search callback
            $("#dosearch").click(function () {
                if (me.options.searchCallback){
                    me.options.searchCallback();

                }
            });

            //delete callbcak
            $("#delete").click(function () {
                if(me.options.deleteCallback){
                    if (me.isall==0) {
                        me.options.deleteCallback(me.checkboxArray,me.isall);
                    }else{
                        me.options.deleteCallback(me.allExcept,me.isall)
                    }

                }
            });

            //send callback
            $("#send").click(function(){
                if(me.options.sendCallback){
                    if (me.isall==0){
                        me.options.sendCallback(me.checkboxArray,me.isall);
                    }else {
                        me.options.sendCallback(me.allExcept,me.isall);
                    }

                }
            });

        },
        addFunction:function(){
            var me = this;
            //div could be clicked
            if(me.chooseFlag==0){
                $(".tdata").on('click',function () {
                    var id = $(this).find('input[type=checkbox]').val();
                    if(me.options.divbutton){
                        me.options.divbutton(id);
                    }
                });
            };


            //checked the checkcbox
            $("input[type=checkbox]").click(function () {
                check(this);
            });


            function check(checkbox) {
                if (me.isall==0){
                    if ($(checkbox).prop("checked")) {
                        me.checkboxArray.push($(checkbox).val());
                    } else {
                        var pos = $.inArray($(checkbox).val(), me.checkboxArray);
                        me.checkboxArray.splice(pos, 1);
                    }
                }
                if (me.isall==1){
                    if ($(checkbox).prop("checked")){
                        var pos = $.inArray($(checkbox).val(), me.allExcept);
                        if (pos!=-1){
                            me.allExcept.splice(pos,1);
                        }
                    }else {
                        me.allExcept.push($(checkbox).val());
                    }
                }


            };



        },
        justCss:function () {
            var me = this;
            var width = me.element.width();
            var height = me.element.height();


            $(".search").css({
                height:height - 80
            });

            if(me.options.addBtn==undefined){
                $("#add").hide();
            }

            /*if(me.checkboxArray==[]){
                $("#all").hide();
                $("#allspan").hide();
            }
*/
            if(me.options.sendCallback==undefined){
                $("#send").hide();
            }
            $("#"+me.options.search).css({
                width:'100%',
                height:"calc("+height+ "px - 80px - 30px - 40px )",
                overflowY:'scroll'
            });

            $(".info").height(height - 80);

            $(".thead").css({
                height : "calc((100% / "+(me.options.size+1)+") - 10px)"
            });
            $(".tdata").css({
               height:"calc((100% / "+(me.options.size+1)+") - 10px)"
            });
            $(".info ul").css({
                width:"calc(100% - 40px)"
            });
            $(".info ul li").css({
                width:"calc(100% / "+me.options.title.length+")"
            });






        },
        refresh:function (content) {
            var me = this;
           /* if(ids!=undefined){
                for(var i =0;i<ids.length;i++){
                    ids[i]=String(ids[i]);
                }
                me.ids=ids;
                me.checkboxArray=[];
            }*/

            $(".tdata").remove();
            for (var i =0;i<content.length;i++){
                var tdata = $("<div class='tdata'></div>");
                var checkbox = $("<div class='checkbox'></div>");
                var checkboxinput = $("<input type='checkbox'>").val(content[i][me.options.id]);
                if(me.chooseFlag==0){
                    $(checkbox).css("display","none");
                }else{
                    $(checkbox).css("display","flex");
                }
                if (me.isall==0){
                    var pos = $.inArray($(checkboxinput).val(),me.checkboxArray);
                    if(pos!=-1){
                        $(checkboxinput).prop("checked",true);
                    }
                }else {
                    $(checkboxinput).prop("checked",true);
                    var pos = $.inArray($(checkboxinput).val(),me.allExcept);
                    if (pos!=-1){
                        $(checkboxinput).prop("checked",false);
                    }
                }


                var dataUl = $("<ul></ul>");
                for (var j = 0;j<me.options.title.length;j++){

                    var dataLi = $("<li></li>");
                    if(me.options.title[j].show!=undefined){
                        dataLi.append(me.options.title[j].show[content[i][me.options.title[j].property]]);
                    }else{
                        dataLi.append(content[i][me.options.title[j].property]);
                    }
                    dataUl.append(dataLi);
                }
                checkbox.append(checkboxinput);
                tdata.append(checkbox).append(dataUl);
                $(".info").append(tdata);
            }

            me.justCss();
            me.addFunction();

        },
    };

    $.fn.table=function(options){
        return new Table($(this),options);
    }

})(jQuery,window,document);

