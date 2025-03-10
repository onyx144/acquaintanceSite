function capture_video_frame(video, format) {
    if (typeof video === 'string') {
        video = document.getElementById(video);
    }

    format = format || 'jpeg';

    if (!video || (format !== 'png' && format !== 'jpeg')) {
        return false;
    }

    var canvas = document.createElement("canvas");

    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;

    canvas.getContext('2d').drawImage(video, 0, 0);


    var dataUri = canvas.toDataURL('image/' + format);
    var data = dataUri.split(',')[1];
    var mimeType = dataUri.split(';')[0].slice(5)

    var bytes = window.atob(data);
    var buf = new ArrayBuffer(bytes.length);
    var arr = new Uint8Array(buf);

    for (var i = 0; i < bytes.length; i++) {
        arr[i] = bytes.charCodeAt(i);
    }

    var blob = new Blob([ arr ], { type: mimeType });
    return { blob: blob, dataUri: dataUri, format: format };
}
function base64_2_blob(dataURI) {
    var byteString;
    if (dataURI.split(',')[0].indexOf('base64') >= 0)
        byteString = atob(dataURI.split(',')[1]);
    else
        byteString = unescape(dataURI.split(',')[1]);

    var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
    var ia = new Uint8Array(byteString.length);
    for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
    }

    return new Blob([ia], { type:mimeString });
}
(function($){
    $(function(){
		
		$('button[data-dismiss="modal"]').click(function(){
            $('#stripe_modal_pro').modal('close');
            $('#cashfree_modal_box').modal('close');
        });
		
        $('a[href*="#"].smooth').not('[href="#"]').not('[href="#0"]').on('click', function(event) {
            if (
                location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') &&
                location.hostname == this.hostname
            ) {
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    event.preventDefault();
                    $('html, body').animate({
                        scrollTop: target.offset().top - 40
                    }, 1000, function() {
                        var $target = $(target);
                        if ($target.is(":focus")) {
                            return false;
                        } else {
                            $target.attr('tabindex', '-1');
                        }
                    });
                }
            }
        });

        var $ctr = $(".slider_container");

        $( document ).on( 'click', '#btn-take-snapshot', function(e){
            e.preventDefault();
			window.image_data = capture_video_frame(video,'png');
            window.camera_ctx.drawImage(video, 0,0, window.camera_canvas.width, window.camera_canvas.height);
            $('#btn-upload-images').attr('data-snapshot', true);
            $('#btn-upload-images').attr('disabled', false);
            $('#retake_snapshot').removeClass('hide');
            $('#take_snapshot').addClass('hide');
        });

        $( document ).on( 'click', '#btn-retake-snapshot', function(e){
            e.preventDefault();
            $('#retake_snapshot').addClass('hide');
            $('#take_snapshot').removeClass('hide');
        });

        $( document ).on( 'change', '#mobile', function(e){
            e.preventDefault();
            let formData = new FormData();
            formData.append( 'phone_number', $(this).val() );

            if($('#mobile').val() !== '' ) {
                let url = window.ajax + '/useractions/check_phone_number';
                $.ajax({
                    url: url,
                    type: "POST",
                    async: false,
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    timeout: 60000,
                    dataType: false,
                    success: function (result) {
						if (result.status == 200) {
                            if (result.message !== '') {
                                $('#mobile').attr('data-p-verified','no');
								M.toast({html: result.message});
                                //$('#mobile').val('');
                                //$('#mobile').focus();
                                return false;
                            }
                            $('#mobile').attr('data-p-verified','yes');
                        }
                    }
                });
            }
        });

        $( '#image_holder' ).on( 'click', 'img.thumb-image', function(e){
            var id = $( this ).attr( 'id' );
            $("#image_holder").find( '.thumb-image' ).css({'border': 'inherit'});
            $( this ).css({'border': '2px solid #9C27B0'});
            $( '#btn-upload-images' ).attr( 'data-selected', id );
            $( '#btn-upload-images' ).attr( 'disabled', false);
            e.preventDefault();
        });

        $( document ).on( 'change', '#my_country', function(e){
            var is_my_country = $(this).find(':selected').attr('data-country');

            if( is_my_country == 'true' ){
                //$('#_located').removeAttr( 'disabled' );
                //$('#_located').val( window.located );
            }
            $.get( window.ajax + 'profile/set_data', {'show_me_to': $(this).val()} );
            e.preventDefault();
        });
		
		$( document ).on( 'change', '#vpassport_img', function(e){
            var countFiles = $(this)[0].files.length;
            var imgPath = $(this)[0].value;
            var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
            var image_holder = $("#image_holder");
            var attach = [];
            image_holder.empty();
            if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
                if (typeof(FileReader) != "undefined") {
                    var formData = new FormData();
                    for (var i = 0; i < countFiles; i++) {
                        attach[i] = i;
                        var reader = new FileReader();
                        reader.onload = function(e) {

                        };
                        reader.readAsDataURL($(this)[0].files[i]);
                        formData.append("avaters"+i, $(this)[0].files[i],$(this)[0].files[i].value );
                    }
                    var bar = $('.vpassport_determinate');
                    var progress = $('.vpassport_progress');
                    progress.removeClass('hide');
                    var status = $('#status');
                    $.ajax({
                        beforeSend: function() {
                            progress.css({'display':'block'});
                            progress.removeClass('hide');
                            bar.width('0%');
                            bar.show();
                        },
                        complete: function() {
                        },
                        xhr: function() {
                            var xhr = new window.XMLHttpRequest();
                            xhr.upload.addEventListener("progress", function(evt){
                                if (evt.lengthComputable) {
                                    var percentComplete = evt.loaded / evt.total;
                                    percentComplete = parseInt(percentComplete * 100);
                                    status.html( percentComplete + "%");
                                    bar.width(percentComplete + '%');
                                    if (percentComplete === 100) {
                                    }else{
                                        progress.removeClass('hide');
                                    }
                                }
                            }, false);
                            return xhr;
                        },
                        url: window.ajax + 'profile/upload_verification_passport',
                        type: "POST",
                        async: true,
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        timeout: 60000,
                        dataType: false,
                        success: function(result) {
                            if( result.status == 200 ){
                                var css = {
                                    'background-image': 'url('+ window.media_path + result.files[0] +')',
                                };
                                $( '.dt_selct_avatar_vpassport_img .svg-empty' ).hide();
                                $( '.dt_selct_avatar_vpassport_img' ).css(css);

                                progress.css({'display':'none'});
                                progress.addClass('hide');
                                bar.width('0%');

                                console.log(result.class);
                                if(result.class === "hide"){
                                    $('.verification_requests_footer').addClass('hide');
                                }else{
                                    $('.verification_requests_footer').removeClass('hide');
                                }
                            }
                        }
                    });
                } else {
                    M.toast({html: 'Please select only Images.'});
                }
            }
        });
		
		$( document ).on( 'change', '#vphoto_img', function(e){
            var countFiles = $(this)[0].files.length;
            var imgPath = $(this)[0].value;
            var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
            var image_holder = $("#image_holder");
            var attach = [];
            image_holder.empty();
            if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
                if (typeof(FileReader) != "undefined") {
                    var formData = new FormData();
                    for (var i = 0; i < countFiles; i++) {
                        attach[i] = i;
                        var reader = new FileReader();
                        reader.onload = function(e) {

                        };
                        reader.readAsDataURL($(this)[0].files[i]);
                        formData.append("avaters"+i, $(this)[0].files[i],$(this)[0].files[i].value );
                    }
                    var bar = $('.vphoto_determinate');
                    var progress = $('.vphoto_progress');
                    progress.removeClass('hide');
                    var status = $('#status');
                    $.ajax({
                        beforeSend: function() {
                            progress.css({'display':'block'});
                            progress.removeClass('hide');
                            bar.width('0%');
                            bar.show();
                        },
                        complete: function() {
                        },
                        xhr: function() {
                            var xhr = new window.XMLHttpRequest();
                            xhr.upload.addEventListener("progress", function(evt){
                                if (evt.lengthComputable) {
                                    var percentComplete = evt.loaded / evt.total;
                                    percentComplete = parseInt(percentComplete * 100);
                                    status.html( percentComplete + "%");
                                    bar.width(percentComplete + '%');
                                    if (percentComplete === 100) {
                                    }else{
                                        progress.removeClass('hide');
                                    }
                                }
                            }, false);
                            return xhr;
                        },
                        url: window.ajax + 'profile/upload_verification_photo',
                        type: "POST",
                        async: true,
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        timeout: 60000,
                        dataType: false,
                        success: function(result) {
                            if( result.status == 200 ){
                                var css = {
                                    'background-image': 'url('+ window.media_path + result.files[0] +')'
                                };
                                $( '.dt_selct_avatar_vphoto_img .svg-empty' ).hide();
                                $( '.dt_selct_avatar_vphoto_img' ).css(css);
                                progress.css({'display':'none'});
                                progress.addClass('hide');
                                bar.width('0%');
								console.log(result.class);
                                if(result.class === "hide"){
                                    $('.verification_requests_footer').addClass('hide');
                                }else{
                                    $('.verification_requests_footer').removeClass('hide');
                                }
                            }
                        }
                    });
                } else {
                    M.toast({html: 'Please select only Images.'});
                }
            }
        });

        $( document ).on( 'click', '#btn-upload-profile-images', function(e){
            $('#modal_profileimgs').modal('close');
            $("#ajaxRedirect").attr("data-ajax", '/' + window.loggedin_user);
            $("#ajaxRedirect").click();
            e.preventDefault();
        });
        $( document ).on( 'change', '#profileavatar_img', function(e){
            var countFiles = $(this)[0].files.length;
            var imgPath = $(this)[0].value;
            var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
            if(countFiles > 1) {
                M.toast({html: 'Please select one image only.'});
            } else if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
                var formData = new FormData();
                formData.append("avaters0", $(this)[0].files[0],$(this)[0].files[0].value );

                $( '.dt_avatar_progress' ).removeClass( 'hide' );
                $( '.avatar_imgstatus' ).removeClass( 'hide' );
                $.ajax({
                    xhr: function() {
                        var xhr = new window.XMLHttpRequest();
                        xhr.upload.addEventListener("progress", function(evt){
                            if (evt.lengthComputable) {

                                var percentComplete = evt.loaded / evt.total;
                                percentComplete = parseInt(percentComplete * 100);
                                $( '.avatar_imgdeterminate' ).css({'width': percentComplete + '%'});
                                if (percentComplete === 100) {
                                    $( '.dt_avatar_progress' ).addClass( 'hide' );
                                    $( '.avatar_imgstatus' ).addClass( 'hide' );
                                }
                            }
                        }, false);
                        return xhr;
                    },
                    url: window.ajax + 'profile/upload_avater',
                    type: "POST",
                    async: true,
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    timeout: 60000,
                    dataType: false,
                    success: function(result) {
                        if( result.status == 200 ){
                            $.each( result.files, function(i) {
                                $.get( window.ajax + 'profile/set_avater', { id: result.files[i] } );
                                $('.header_user').find('img').attr( 'src', window.media_path + result.files[i] );
                                $('.avatar').find('img').attr( 'src', window.media_path + result.files[i] );
                            });

                            setTimeout(function() {
                                $("#ajaxRedirect").attr("data-ajax", '/' + window.loggedin_user );
                                $("#ajaxRedirect").click();
                            }, 500);
                        }
                    },
                    error: function (result) {
                        M.toast({html: result.responseJSON.message});
                    }
                });

            }else{
                M.toast({html: 'Please select only Images.'});
            }
        });
        $( document ).on( 'change', '#admin_profileavatar_img', function(e){
            var user_id = $(this).attr( 'data-userid' );
            var user_name = $(this).attr( 'data-username' );
            var formData = new FormData();
            formData.append("avaters0", $(this)[0].files[0],$(this)[0].files[0].value );
            $( '.admin_avatar_imgprogress' ).removeClass( 'hide' );
            $( '.admin_avatar_imgstatus' ).removeClass( 'hide' );
            $.ajax({
                xhr: function() {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function(evt){
                        if (evt.lengthComputable) {

                            var percentComplete = evt.loaded / evt.total;
                            percentComplete = parseInt(percentComplete * 100);
                            $( '.admin_avatar_imgdeterminate' ).css({'width': percentComplete + '%'});
                            if (percentComplete === 100) {
                                $( '.admin_avatar_imgprogress' ).addClass( 'hide' );
                                $( '.admin_avatar_imgstatus' ).addClass( 'hide' );
                            }
                        }
                    }, false);
                    return xhr;
                },
                url: window.ajax + 'profile/upload_avater',
                type: "POST",
                async: true,
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                timeout: 60000,
                dataType: false,
                success: function(result) {
                    if( result.status == 200 ){
                        $.each( result.files, function(i) {
                            $.get( window.ajax + 'profile/set_user_avater', { userid: user_id , id: result.files[i] } );
                            $('.avatar').find('img').attr( 'src', window.media_path + result.files[i] );
                        })
                        setTimeout(function() {
                            $("#ajaxRedirect").attr("data-ajax", '/@' + user_name );
                            $("#ajaxRedirect").click();
                        }, 500);

                    }
                }
            });

        });
        $( document ).on( 'change', '#avatar_profileimg', function(e){
            var countFiles = $(this)[0].files.length;
            var imgPath = $(this)[0].value;
            var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
            var image_holder = $("#profile_image_holder");
            var attach = new Array();
            image_holder.empty();
            if(countFiles > 8) {
                M.toast({html: 'Please select Four Images only.'});
            } else if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg" || extn == "mp4" || extn == "3gp" || extn == "avi" ) {
                if (typeof(FileReader) != "undefined") {
                    var formData = new FormData();
                    //loop for each file selected for uploaded.
                    for (var i = 0; i < countFiles; i++) {
                        attach[i] = i;
                        var reader = new FileReader();
                        reader.onload = function(e) {

                        };
                        reader.readAsDataURL($(this)[0].files[i]);
                        formData.append("avaters"+i, $(this)[0].files[i],$(this)[0].files[i].value );
                    }
                    $('.profile_count_imgs').text(countFiles);
                    var bar = $('#c_det');
                    var status = $('#c_perc');
                    $('#upload_images').modal('open');
                    $.ajax({
                        xhr: function() {
                            var xhr = new window.XMLHttpRequest();
                            xhr.upload.addEventListener("progress", function(evt){
                                if (evt.lengthComputable) {
                                    var percentComplete = evt.loaded / evt.total;
                                    percentComplete = parseInt(percentComplete * 100);
                                    status.html( percentComplete + "%");
                                    bar.width(percentComplete + '%');
                                    if (percentComplete === 100) {
                                        bar.hide();
                                        bar.width('0%');
                                        status.html( "0%");
                                        $('#modal_profileimgs .progress').addClass('hide');
                                        $('#modal_profileimgs #status').addClass('hide');
                                        status.hide();
                                        $( '.select_profile_image' ).show();
                                        $('#upload_images').modal('close');
                                    }
                                }
                            }, false);
                            return xhr;
                        },
                        url: window.ajax + 'profile/upload_avater',
                        type: "POST",
                        async: true,
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        timeout: 60000,
                        dataType: false,
                        success: function(result) {
                            if( result.status == 200 ){
                                $('#modal_profileimgs').modal('close');
                                $("#ajaxRedirect").attr("data-ajax", '/' + window.loggedin_user);
                                $("#ajaxRedirect").click();
                                e.preventDefault();
                            }
                        },
                        error: function (result) {
                            M.toast({html: result.responseJSON.message});
                        }
                    });
                } else {
                    M.toast({html: 'Please select only Images.'});
                }
            } else {
                M.toast({html: "This browser does not support FileReader."});
            }
        });
        $( document ).on( 'click', '#send_otp', function(e){
            e.preventDefault();
            let txt = $(this).text();
            $(this).text("Please wait..").attr('disabled', true);
            $.ajax({
                type: 'GET',
                url: window.ajax + 'useractions/send_verefication_sms',
                data: {phone: $('#mobile_validate').val()},
                success: function(data){
                    if( data.status == 200 ){
                        $('#send_otp').text(txt).attr('disabled', true);
                        $('.enter_otp').fadeIn(100);
                        $('.enter_otp').find('#otp_check_phone').focus();
                    }else{
                        $('#send_otp').text(txt).attr('disabled', false);
                        $('#mobile_validate').focus();
                        M.toast({html: "Cannot send verification sms right now, try again later."});
                    }
                },
                error: function (data) {
                    $('#send_otp').text(txt).attr('disabled', false);
                    $('#mobile_validate').focus();
                    M.toast({html: data.responseJSON.message});
                },
            });
        });
        $( document ).on( 'keypress', '#otp_check', function(e){
            if($(this).val().length == 3) {
                $('form.slider-three').find('button.reset').attr('disabled', false);
            } else {}
        });
        $( document ).on( 'click', '#send_otp_email', function(e){
            e.preventDefault();
            let default_email = $('#email').attr('data-email');
            let email = $('#email').val();
            let txt = $(this).text();
            $(this).text("Please wait..").attr('disabled', true);
            let formData = new FormData();
            formData.append("email", email );
            $.ajax({
                type: 'POST',
                url: window.ajax + '/useractions/send_verefication_email',
                data: {"email":email},
                processData: true,
                success: function(data) {
                    if( data.status == 200 ){
                        $('#send_otp_email').text(txt).attr('disabled', true);
                        $('.enter_otp_email').fadeIn(100);
                        $('.enter_otp_email').find('#otp_check_email').focus();
                    }
                },
                error: function (data) {
                    M.toast({html:data.responseJSON.message});
                    setTimeout(function(){
                        $('#send_otp_email').text(txt).attr('disabled', null);
                        $('#email').attr('value',default_email);
                        $('#email').val(default_email);
                    },1000);
                }
            });

        });
        $( document ).on( 'click', '#send_report_btn', function(e){
            e.preventDefault();
            let report_content = $.trim($("#report_content").val());
            let userid = $('#send_report_btn').attr('data-userid');
            $.ajax({
                type: 'POST',
                url: window.ajax + '/useractions/report',
                data: {'report_content': report_content,'userid' : userid},
                processData: true,
                success: function(data) {
                    if( data.status == 200 ){
                        $('#modal_report').modal("close");
                        $('#report_content').val('');
                        $( '.report_text' ).attr( 'data-ajax-post', '/useractions/unreport' );
                        $( '.report_text' ).attr( 'data-ajax-callback', 'callback_unreport' );
                        $( '.report_text' ).attr( 'data-ajax-params', 'userid='+userid );
                        $( '.report_text' ).html( '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#444" d="M6,2H14L20,8V20A2,2 0 0,1 18,22H6C4.89,22 4,21.1 4,20V4C4,2.89 4.89,2 6,2M13,9H18.5L13,3.5V9M10,14.59L7.88,12.46L6.46,13.88L8.59,16L6.46,18.12L7.88,19.54L10,17.41L12.12,19.54L13.54,18.12L11.41,16L13.54,13.88L12.12,12.46L10,14.59Z"></path></svg>' );
                        $( '.report_text' ).removeClass('modal-trigger');
                        $( '.report_text' ).attr('href','javascript:void(0);');
                    }
                },
                error: function (data) {
                    M.toast({html:data.responseJSON.message});
                    setTimeout(function(){
                        $('#modal_report').modal("close");
                        $('#report_content').val('');
                    },1000);
                }
            });
        });
        
        $( document ).on( 'paste', '#otp_check_forget_email', function(e){
            var pastedData = e.originalEvent.clipboardData.getData('text');
            if(pastedData.length === 4) {
                var vl = $(this);
                vl.val(pastedData);
                verify_email_code(this);

            } else {}
            e.preventDefault();
        });
        $( document ).on( 'keypress', '#otp_check_forget_email', function(e){
            if (e.keyCode == 13) {
                e.preventDefault();

                if($(this).val().length === 4) {
                    verify_email_code(this);
                } else {}
            }
        });
        $( document ).on( 'paste', '#otp_check_forget_phone', function(e){
            var pastedData = e.originalEvent.clipboardData.getData('text');
            if(pastedData.length === 4) {
                var vl = $(this);
                vl.val(pastedData);
                verify_sms_code(this);
            } else {}
            e.preventDefault();
        });
        $( document ).on( 'keypress', '#otp_check_forget_phone', function(e){
            if (e.keyCode == 13) {
                e.preventDefault();
                if($(this).val().length === 4) {
                    verify_sms_code(this);
                } else {}
            }
        });
        $( document ).on( 'click', '.dt_plans label', function(){
            $('.pay_using').removeClass('hidden');
        });

    });
})(jQuery);

(function($){
    $(function(){
        $( document ).on( 'click', '#mylikes', function(e) {
            $('#likes_modal').removeClass('hide');
            $('#likes_modal').addClass('modal');
            $('#likes_modal').modal({
                onOpenEnd: function () {
                    $.ajax({
                        cache: false,
                        type: "GET",
                        timeout: 5000,
                        url:  window.ajax + '/profile/get_profile_likes',
                        success: function(result) {
                            if(result.status == 200 ){
                                $('.dt_modal_user_list_profile').html(result.likes);
                            }
                        },
                        error: function(result) {

                        }
                    });
                }
            }).modal("open");
        });
        $( document ).on( 'click', '#myViews', function(e) {
            $('#views_modal').removeClass('hide');
            $('#views_modal').addClass('modal');
            $('#views_modal').modal({
                onOpenEnd: function () {
                    $.ajax({
                        cache: false,
                        type: "GET",
                        timeout: 5000,
                        url:  window.ajax + '/profile/get_profile_views',
                        success: function(result) {
                            if(result.status == 200 ){
                                $('.dt_modal_user_vlist_profile').html(result.views);
                            }
                        },
                        error: function(result) {

                        }
                    });
                }
            }).modal("open");
        });
    });
})(jQuery);

// find match
(function($){
    $(function(){



        $( document ).on("click", "#btn-try-again", function(e){
            e.preventDefault();
            window.location.reload();
        });

        $( document ).on("keypress", "#search-blog-input", function(e){
            if(e.which == 13){
                var inputVal = $(this).val();
                $('#load-search-icon').removeClass('hide');

                let formData = new FormData();
                    formData.append( 'keyword', inputVal );

                let url = window.ajax + '/loadmore/blog_search';
                $.ajax({
                    url: url,
                    type: "POST",
                    // async: false,
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    timeout: 60000,
                    dataType: false,
                    success: function(result) {
                        if(result.status == 200){
                            $('#load-search-icon').addClass('hide');
                            $('#btn_load_more_articles').addClass('hide');

                            $('#articles_container').html(result.html);
                        }
                    }
                });

            }
        });

        $( document ).on( 'click', '#btn_buymore_xvisits', function(e){
            e.preventDefault();
            let formData = new FormData();
            formData.append( 'uid', $(this).attr('data-userid') );

            let url = window.ajax + '/profile/buymore_xvisits';
            $.ajax({
                url: url,
                type: "POST",
                async: false,
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                timeout: 60000,
                dataType: false,
                success: function(result) {
                    if(result.status == 200){
                        $('#buy_xvisits').modal('close');
                        $('#credit_amount').html(result.current_credit);
                        $("#ajaxRedirect").attr("data-ajax", '');
                        $("#ajaxRedirect").attr("data-ajax", '/popularity');
                        $("#ajaxRedirect").click();
                    }
                }
            });
        });

        $( document ).on( 'click', '#btn_buymore_xmatches', function(e){
            e.preventDefault();
            let formData = new FormData();
            formData.append( 'uid', $(this).attr('data-userid') );
            let url = window.ajax + '/profile/buymore_xmatches';
            $.ajax({
                url: url,
                type: "POST",
                async: false,
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                timeout: 60000,
                dataType: false,
                success: function(result) {
                    if(result.status == 200){
                        $('#buy_xmatches').modal('close');
                        $('#credit_amount').html(result.current_credit);
                        $("#ajaxRedirect").attr("data-ajax", '');
                        $("#ajaxRedirect").attr("data-ajax", '/popularity');
                        $("#ajaxRedirect").click();
                    }
                }
            });
        });

        $( document ).on( 'click', '#btn_buymore_xlikes', function(e){
            e.preventDefault();
            let formData = new FormData();
            formData.append( 'uid', $(this).attr('data-userid') );
            let url = window.ajax + '/profile/buymore_xlikes';
            $.ajax({
                url: url,
                type: "POST",
                async: false,
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                timeout: 60000,
                dataType: false,
                success: function(result) {
                    if(result.status == 200){
                        $('#buy_xlikes').modal('close');
                        $('#credit_amount').html(result.current_credit);
                        $("#ajaxRedirect").attr("data-ajax", '');
                        $("#ajaxRedirect").attr("data-ajax", '/popularity');
                        $("#ajaxRedirect").click();
                    }
                }
            });
        });
        $( document ).on( 'click', '#btn_buymore_chat_credit', function(e){
            e.preventDefault();
            let formData = new FormData();
            formData.append( 'uid', $(this).attr('data-userid') );
            formData.append( 'chat_uid', $(this).attr('data-chat-userid') );
            let url = window.ajax + '/chat/buymore_chat_credit';
            $.ajax({
                url: url,
                type: "POST",
                async: false,
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                timeout: 60000,
                dataType: false,
                success: function(result) {
                    if(result.status == 200){
                        $('#buy_chat_credits').modal('close');
                        $('#credit_amount').html(result.current_credit);
                        $('[data-ajax-callback="open_private_conversation"]').trigger('click');
                    }
                }
            });
        });
        $( document ).on( 'click', '#btn_buystikcers', function(e){
            e.preventDefault();
            let formData = new FormData();
            formData.append( 'uid', $(this).attr('data-userid') );
            let url = window.ajax + '/chat/buystickers';
            $.ajax({
                url: url,
                type: "POST",
                async: false,
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                timeout: 60000,
                dataType: false,
                success: function(result) {
                    if(result.status == 200){
                        $('#credit_amount').html(result.current_credit);
                        $('#stikerlist').empty();
                        $('#chat_message_upload_stiker').trigger('click');
                    }
                }
            });
        });
        $( document ).on( 'click', '#boost_btn', function(e){
            e.preventDefault();
            $('#modal_boost').modal('open');
        });
        $( document ).on( 'click', '#btn_boostme', function(e){
            e.preventDefault();
            let formData = new FormData();
            formData.append( 'uid', $(this).attr('data-userid') );
            let url = window.ajax + '/useractions/boostnow';
            $.ajax({
                url: url,
                type: "POST",
                async: false,
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                timeout: 60000,
                dataType: false,
                success: function(result) {
                    if(result.status == 200){
                        location.reload();
                        $('#credit_amount').html(result.current_credit);
                        $('#modal_boost').modal('close');
                        $("#ajaxRedirect").attr("data-ajax", '');
                        $("#ajaxRedirect").attr("data-ajax", '/find-matches');
                        $("#ajaxRedirect").click();
                    }
                }
            });
        });
		
        $( document ).on( 'click', '.btn-find-matches-search', function(e) {
            e.preventDefault();
            var formData = new FormData();

            // search_basic
            var gender = [];
            $("._gender:checked").each ( function() {
                gender.push($(this).val());
            });
            if(gender.length > 0) {
                formData.append('_gender', gender);
            }
            formData.append( '_age_from', $('._age_from').find(":selected").val() );
            formData.append( '_age_to', $('._age_to').find(":selected").val() );
			if( $('#is_my_location').prop('checked') !== false) {
                formData.append( '_located', $('#_located').val() );
                formData.append( '_lat', $('#_lat').val() );
                formData.append( '_lng', $('#_lng').val() );
            }
            else{
                formData.append( '_my_country', $('#my_country').find(":selected").val() );
            }
            formData.append('_location', '');

            // search_looks
            var body = [];
            $("._body:checked").each ( function() {
                body.push($(this).val());
            });
            if(body.length > 0) {
                formData.append('_body', body);
            }
            formData.append( '_height_from', $('.height_from').find(":selected").val() );
            formData.append( '_height_to', $('.height_to').find(":selected").val() );


            // search_background
            var ethnicity = [];
            $("._ethnicity:checked").each ( function() {
                ethnicity.push($(this).val());
            });
            var religion = [];
            $("._religion:checked").each ( function() {
                religion.push($(this).val());
            });
            if(ethnicity.length > 0) {
                formData.append('_ethnicity', ethnicity);
            }
            if(religion.length > 0) {
                formData.append('_religion', religion);
            }
            formData.append( '_language', $('._language').find(":selected").val() );


            // search_lifestyle
            var relationship = [];
            $("._relationship:checked").each ( function() {
                relationship.push($(this).val());
            });
            var smoke = [];
            $("._smoke:checked").each ( function() {
                smoke.push($(this).val());
            });
            var drink = [];
            $("._drink:checked").each ( function() {
                drink.push($(this).val());
            });
            if(relationship.length > 0){
                formData.append( '_relationship', relationship );
            }
            if(smoke.length > 0){
                formData.append( '_smoke', smoke );
            }
            if(drink.length > 0){
                formData.append( '_drink', drink );
            }


            // search_more
            var education = [];
            $("._education:checked").each ( function() {
                education.push($(this).val());
            });
            var pets = [];
            $("._pets:checked").each ( function() {
                pets.push($(this).val());
            });
            if(education.length > 0){
                formData.append( '_education', education );
            }
            if(pets.length > 0){
                formData.append( '_pets', pets );
            }
            formData.append( '_interest', $('#interest').val() );
            $(".profile_custom_data_field").each ( function() {
                formData.append( $(this).attr('data-name'), $(this).val() );
            });
            if( $(".profile_custom_data_field").length > 0 ){
                formData.append( 'custom_profile_data', 'true' );
            }
			if( $(".selected_city").length > 0 ){
                formData.append( 'city', $(".selected_city").val() );
            }


            formData.append( 'page', '1' );
            var url = window.ajax + '/loadmore/match_users';
            $.ajax({
                url: url,
                type: "POST",
                async: false,
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                timeout: 60000,
                dataType: false,
                success: function(result) {
					$('.to_side_filters').modal('close');
					$('body').removeClass('filtr_active');
                    //$('#search_users_container').empty();
                    callback_load_more_search_users( result );
                }
            });
        });


        $( document ).on( 'click', '._gender', function(e) {
            var self = this;
            $('._gender').each(function () {
                if ($(self).is(':checked') && $(self).attr('data-vx') == '_all_' && $(this).attr('data-vx') != '_all_' && $(this).is(':checked')) {
                    $(this).prop('checked',false);
                }
                else if($(self).is(':checked') && $(self).attr('data-vx') != '_all_' && $(this).attr('data-vx') == '_all_'){
                    $(this).prop('checked',false);
                }
            });
            let gList = [];
            $('._gender').each(function () {
                if (this.checked) {
                    gList.push($(this).attr('data-txt'));
                }
            });
            $('#gender').html( gList.join(',') );
            if (gList.length == 0) {
                $("[data-vx='_all_']").prop('checked',true);
                $('#gender').html($("[data-vx='_all_']").attr('data-txt'));
            }
        });
        $( document ).on( 'change', '._age_from', function(e){
            var optionSelected = $("option:selected", this);
            var valueSelected = this.value;
            $('#age_from').html(valueSelected);
        });
        $( document ).on( 'change', '._age_to', function(e){
            var optionSelected = $("option:selected", this);
            var valueSelected = this.value;
            $('#age_to').html(valueSelected);
        });
        $( document ).on( 'keyup', '#_location', function(e){
            var valueSelected = this.value;
            $('#location').html(valueSelected);
        });
        $( document ).on( 'click', '.gift-data', function(e) {
            e.preventDefault();
            let id = $(this).attr('data-id');
            $('.gift-data').css({'border':'none'});
            $(this).css({'border':'2px solid #d35147'});
            if( id > 0 ){
                $('#btn-send-gift').attr('disabled',null);
                $('#btn-send-gift').attr('data-selected',id);
            }
        });
        $( document ).on( 'click', '#btn-send-gift', function(e) {
            e.preventDefault();
            let id = $(this).attr('data-selected');
            let to = $(this).attr('data-to');
            if( id > 0  && to > 0){
                var url = window.ajax + '/profile/send_gift';
                var formData = new FormData();
                formData.append("gift_id", id );
                formData.append("to", to );
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: formData,
                    contentType:false,
                    cache: false,
                    processData:false,
                    success: function(data){
                        if(data.status == 200) {
                            $('#credit_amount').html(data.current_credit);
                            $('#modal_gifts').modal({}).modal("close");
                            if( data.current_credit >= data.cost_per_gift ){
                                $('#gifts_container').show();
                                $('#send_gift_footer').show();
                                $('#buy_credits_gift').addClass('hide');
                            }else{
                                $('#gifts_container').remove();
                                $('#send_gift_footer').remove();
                                $('#buy_credits_gift').removeClass('hide');
                            }
                        }
                    },
                    error: function (data) {},
                });
                e.preventDefault();
            }else{
                $('#btn-send-gift').attr('disabled',true);
                $('#btn-send-gift').attr('data-selected','');
            }
        });
        $( document ).on( 'click', 'button.like', function(e) {
            e.preventDefault();
            if( window.swaps > window.max_swaps ) return;
            window.swaps = window.swaps + 1;
            var data_replace_text = $(this).attr('data-replace-text');
            var data_replace_dom = $(this).attr('data-replace-dom');
            let source = '';
            $(this).toggle('active');
            if( typeof $(this).attr('data-source') !== "undefined" ){
                if( $(this).attr('data-source') == 'find-matches' ){
                    source = 'find-matches';
                }
            }
            if (typeof data_replace_text !== typeof undefined && data_replace_text !== false) {
                if (typeof data_replace_dom !== typeof undefined && data_replace_dom !== false) {
                    $(data_replace_dom).html(data_replace_text);
                }
            }
            $('.random_user_item[data-uid="'+$(this).attr('data-userid')+'"]').remove();
            // if($(this).attr('id') == 'like_btn') {
            //     $('.mtc_usrd_content[data-id="' + $(this).attr('data-userid') + '"]').next().show();
            //     $('.mtc_usrd_content[data-id="' + $(this).attr('data-userid') + '"]').remove();
            // }
            let users = $( '.usr_thumb' ).length;
            let obj = $(this).closest('.mtc_usrd_content');
            let thumb = $( '.usr_thumb.isActive' );
            if( users > 0 ) {

                if($(this).attr('id') == 'matches_like_btn') {
                    thumb.next().addClass('isActive');
                    obj.next().show();
                    thumb.remove();
                    obj.remove();
                }

            }
            if($(this).hasClass('hot')){
                var execlude = [];
                $('#avaters_item_container .usr_thumb').each(function(i, obj) {
                    //console.log(i, $(obj).attr('data-id') );
                    execlude.push($(obj).attr('data-id'));
                });
                //console.log(execlude.join());
                var lastid = $('#avaters_item_container div:last-child').attr('data-id');
                $('#btn_load_more_match_users').attr('data-ajax-post', '/loadmore/match_users?mode=hot&lastid='+lastid+'&execlude='+execlude.join());
            }
			
            if( users < 7 ) {
               // console.log(window.ajaxsend )
               // if(window.ajaxsend == true) {
                //console.log( lastid)
                    //console.log($('#btn_load_more_match_users').attr('data-ajax-params'));
                    $('#btn_load_more_match_users').trigger('click');
                    $('#btn_load_more_match_users').attr('id', 'btn_load_more_match_users1');
                //}
            }else if( users == 1 ) {
                $('.mtc_usr_details').html('<h5 class="empty_state"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M9,4A4,4 0 0,1 13,8A4,4 0 0,1 9,12A4,4 0 0,1 5,8A4,4 0 0,1 9,4M9,6A2,2 0 0,0 7,8A2,2 0 0,0 9,10A2,2 0 0,0 11,8A2,2 0 0,0 9,6M9,13C11.67,13 17,14.34 17,17V20H1V17C1,14.34 6.33,13 9,13M9,14.9C6.03,14.9 2.9,16.36 2.9,17V18.1H15.1V17C15.1,16.36 11.97,14.9 9,14.9M15,4A4,4 0 0,1 19,8A4,4 0 0,1 15,12C14.53,12 14.08,11.92 13.67,11.77C14.5,10.74 15,9.43 15,8C15,6.57 14.5,5.26 13.67,4.23C14.08,4.08 14.53,4 15,4M23,17V20H19V16.5C19,15.25 18.24,14.1 16.97,13.18C19.68,13.62 23,14.9 23,17Z"></path></svg>'+$('#btn_load_more_match_users').attr( 'data-lang-nomore')+'</h5>');
            }
            $('.usr_thumb').hide();
            $('.usr_thumb:lt(8)').show();
        });
        $( document ).on( 'click', 'button.dislike', function(e) {
            e.preventDefault();
            $(this).toggle('active');
            let source = '';
            if( typeof $(this).attr('data-source') !== "undefined" ){
                if( $(this).attr('data-source') == 'find-matches' ){
                    source = 'find-matches';
                }
            }
            if( window.swaps > window.max_swaps ) return;
            window.swaps = window.swaps + 1;
            $('.random_user_item[data-uid="'+$(this).attr('data-userid')+'"]').remove();
            // if($(this).attr('id') == 'dislike_btn') {
            //     $('.mtc_usrd_content[data-id="' + $(this).attr('data-userid') + '"]').next().show();
            //     $('.mtc_usrd_content[data-id="' + $(this).attr('data-userid') + '"]').remove();
            // }

            let users = $( '.usr_thumb' ).length;
            let obj = $(this).closest('.mtc_usrd_content');
            let thumb = $( '.usr_thumb.isActive' );
            if( users > 0 ) {
                if($(this).attr('id') == 'matches_dislike_btn') {
                    thumb.next().addClass('isActive');
                    obj.next().show();
                    thumb.remove();
                    obj.remove();
                }
            }
            if($(this).hasClass('hot')){
                var lastid = $('#avaters_item_container div:last-child').attr('data-id');
                $('#btn_load_more_match_users').attr('data-ajax-post', '/loadmore/match_users?mode=hot&lastid='+lastid);
            }
            if( users < 7 ) {
                //console.log('yget new users');
                $('#btn_load_more_match_users').trigger('click');
                $('#btn_load_more_match_users').attr('id', 'btn_load_more_match_users1');
            }
            else if( users == 1 && source !== 'find-matches' ) {
                $('.mtc_usr_details').html('<h5 class="empty_state"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M9,4A4,4 0 0,1 13,8A4,4 0 0,1 9,12A4,4 0 0,1 5,8A4,4 0 0,1 9,4M9,6A2,2 0 0,0 7,8A2,2 0 0,0 9,10A2,2 0 0,0 11,8A2,2 0 0,0 9,6M9,13C11.67,13 17,14.34 17,17V20H1V17C1,14.34 6.33,13 9,13M9,14.9C6.03,14.9 2.9,16.36 2.9,17V18.1H15.1V17C15.1,16.36 11.97,14.9 9,14.9M15,4A4,4 0 0,1 19,8A4,4 0 0,1 15,12C14.53,12 14.08,11.92 13.67,11.77C14.5,10.74 15,9.43 15,8C15,6.57 14.5,5.26 13.67,4.23C14.08,4.08 14.53,4 15,4M23,17V20H19V16.5C19,15.25 18.24,14.1 16.97,13.18C19.68,13.62 23,14.9 23,17Z"></path></svg>'+$('#btn_load_more_match_users1').attr( 'data-lang-nomore')+'</h5>');
            }
            if( users == 1 && source == 'find-matches' ) {
                $('.mtc_usr_details').html('<h5 class="empty_state"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M9,4A4,4 0 0,1 13,8A4,4 0 0,1 9,12A4,4 0 0,1 5,8A4,4 0 0,1 9,4M9,6A2,2 0 0,0 7,8A2,2 0 0,0 9,10A2,2 0 0,0 11,8A2,2 0 0,0 9,6M9,13C11.67,13 17,14.34 17,17V20H1V17C1,14.34 6.33,13 9,13M9,14.9C6.03,14.9 2.9,16.36 2.9,17V18.1H15.1V17C15.1,16.36 11.97,14.9 9,14.9M15,4A4,4 0 0,1 19,8A4,4 0 0,1 15,12C14.53,12 14.08,11.92 13.67,11.77C14.5,10.74 15,9.43 15,8C15,6.57 14.5,5.26 13.67,4.23C14.08,4.08 14.53,4 15,4M23,17V20H19V16.5C19,15.25 18.24,14.1 16.97,13.18C19.68,13.62 23,14.9 23,17Z"></path></svg>'+$('#btn_load_more_match_users1').attr( 'data-lang-nomore')+'</h5>');
            }
            $('.usr_thumb').hide();
            $('.usr_thumb:lt(8)').show();
        });
    });



    $( document ).on( 'click', '#disapprove_story', function(e) {
        e.preventDefault();
        console.log('disapprove_story');
        let btn = $(this);
        let storyid = $(this).attr('data-storyid');
        let storyuserid = $(this).attr('data-story-userid');
        let story_to_userid = $(this).attr('data-story-to-userid');

        var url = window.ajax + '/profile/disapprove_story';
        var formData = new FormData();
        formData.append("storyid", storyid );
        formData.append("storyuserid", storyuserid );
        formData.append("story_to_userid", story_to_userid );

        $.ajax({
            type: 'POST',
            url: url,
            data: formData,
            contentType:false,
            cache: false,
            processData:false,
            success: function(data){

            },
            error: function (data) {},
        });
    });

    $( document ).on( 'click', '#approve_story', function(e) {
        e.preventDefault();
        console.log('approve_story');
        let btn = $(this);
        let storyid = $(this).attr('data-storyid');
        let storyuserid = $(this).attr('data-story-userid');
        let story_to_userid = $(this).attr('data-story-to-userid');

        var url = window.ajax + '/profile/approve_story';
        var formData = new FormData();
        formData.append("storyid", storyid );
        formData.append("storyuserid", storyuserid );
        formData.append("story_to_userid", story_to_userid );

        $.ajax({
            type: 'POST',
            url: url,
            data: formData,
            contentType:false,
            cache: false,
            processData:false,
            success: function(data){
                window.location = data.url;
            },
            error: function (data) {},
        });
    });
	
	$( document ).on( 'click', '#disapprove_friend_request', function(e) {
        e.preventDefault();
        let btn = $(this);
        let friend_requestuserid = $(this).attr('data-friend-request-userid');
        let friend_request_to_userid = $(this).attr('data-friend-request-to-userid');

        var url = window.ajax + '/profile/disapprove_friend_request';
        var formData = new FormData();
        formData.append("friend_request_userid", friend_requestuserid );
        formData.append("friend_request_to_userid", friend_request_to_userid );

        $.ajax({
            type: 'POST',
            url: url,
            data: formData,
            contentType:false,
            cache: false,
            processData:false,
            success: function(data){
                $("#ajaxRedirect").attr("data-ajax", data.ajaxRedirect);
                $("#ajaxRedirect").click()
            },
            error: function (data) {},
        });
    });

    $( document ).on( 'click', '#approve_friend_request', function(e) {
        e.preventDefault();
        let btn = $(this);
        let friend_request_userid = $(this).attr('data-friend-request-userid');
        let friend_request_to_userid = $(this).attr('data-friend-request-to-userid');

        var url = window.ajax + '/profile/approve_friend_request';
        var formData = new FormData();
        formData.append("friend_request_userid", friend_request_userid );
        formData.append("friend_request_to_userid", friend_request_to_userid );

        $.ajax({
            type: 'POST',
            url: url,
            data: formData,
            contentType:false,
            cache: false,
            processData:false,
            success: function(data){

                $("#ajaxRedirect").attr("data-ajax", data.ajaxRedirect);
                $("#ajaxRedirect").click()

            },
            error: function (data) {},
        });
    });

})(jQuery);

function event_runner(ajax){
    if($('#_location').length) {
        initAutocomplete();
    }
    if($('#ulocation').length) {
        initAutocomplete();
    }
    var h, i;
    var dataValues = [];
    var svgs = document.querySelectorAll('.user_popularity_icn');
    for (i = 0; i < svgs.length; i++) {
        dataValues.push(svgs[i].dataset["value"]);
    }
    function drawcircles() {
        var circlelines = document.querySelectorAll('.load-circle');
        for (h = 0; h < circlelines.length; h++) {
            var totalLength = circlelines[h].getTotalLength();
            var offset = totalLength - ((dataValues[h] / 100) * totalLength);
            circlelines[h].style.transitionDuration = '1.3s';
            circlelines[h].style.strokeDashoffset = offset + "px";
        }
    }
    drawcircles();
    if($('#chat_time').length){
        $('#chat_time').each(function(i){
            var tm = $(this).attr('data-chat-time');
            var upgradeTime = tm;
            var seconds = upgradeTime;
            var $div = $(this);
            var countdownTimer = setInterval(function(){
                var days        = Math.floor(seconds/24/60/60);
                var hoursLeft   = Math.floor((seconds) - (days*86400));
                var hours       = Math.floor(hoursLeft/3600);
                var minutesLeft = Math.floor((hoursLeft) - (hours*3600));
                var minutes     = Math.floor(minutesLeft/60);
                var remainingSeconds = seconds % 60;
                function pad(n) {
                    return (n < 10 ? "0" + n : n);
                }
                $div.html( pad(hours) + ":" + pad(minutes) + ":" + pad(remainingSeconds) );
                if (seconds == 0) {
                    clearInterval(countdownTimer);
                    $div.html("Completed");
                } else {
                    seconds--;
                }
            }, 1000);
        });
    }
    if ($('.boosted_time').length) {
        $('.boosted_time').each(function (i) {
            var _Minutes = 60 * $(this).attr('data-boosted-time');
            _startTimer(_Minutes, $(this));
        });
    }
    if(ajax === false) {
        if ($('.global_boosted_time').length) {
            $('.global_boosted_time').each(function (i) {
                var _Minutes = 60 * $(this).attr('data-boosted-time');
                _startTimer(_Minutes, $(this));
            });
        }
    }
    if($('.received_gift_modal').length){
        $('.received_gift_modal').each(function(i){
            let gift_id = $(this).attr('data-gift-id');
            let gift_div = $(this);
            $(this).removeClass('hide').addClass('modal').addClass('modal_sm');
            $(this).modal({
                onOpenEnd: function () {

                },
                onCloseEnd: function () {
                    var url = window.ajax + '/profile/record_gift_seen';
                    var formData = new FormData();
                    formData.append("id", gift_id );
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: formData,
                        contentType:false,
                        cache: false,
                        processData:false,
                        success: function(data){
                            if(data.status == 200) {
                                gift_div.remove();
                            }
                        },
                        error: function (data) {},
                    });
                }
            }).modal("open");
        });
    }
    if($('#story_approval').length) {
        $('#story_approval').modal({
            onOpenEnd: function () {

            },
            onCloseEnd: function () {

            }
        }).modal("open");
    }
    if ($('.match_usr_img_slidr').length > 0) {
        if ($('.match_usr_img_slidr').html().trim() !== '') {
            try {
                $('.match_usr_img_slidr').carousel({
                    fullWidth: true,
                    indicators: false
                });
            } catch(e) {}
        }
    }

}
$(window).on('load',function() {
    event_runner(false);
});
function clickAndDisable(link) {
    link.className += " disabled";
    link.onclick = function(event) {
        event.preventDefault();
    }
}
function createCookie(name,value) {
    var date = new Date();
    date.setTime(date.getTime()+(10 * 365 * 24 * 60 * 60 * 1000 ) );
    var expires = "; expires="+date.toGMTString();
    document.cookie = name+"="+value+expires+"; path=/;SameSite=None;Secure";
}
function decodeHtml(html) {
    var txt = document.createElement("textarea");
    txt.innerHTML = html;
    return txt.value;
}
function init_load_more(data,button,container,template){
    let params = button.attr('data-ajax-params');
    let search = "page=";
    search += data.page - 1;
    let replacement = "page=" + data.page;
    button.attr('data-ajax-params', params.replace(new RegExp(search, 'g'), replacement));
    if( template.length == 0 && data.html !== ''){
        container.append(data.html);
        return true;
    }else if( template.length == 0 && data.html == '') {
        button.html(button.attr('data-lang-nomore'));
        button.removeAttr('data-ajax-params');
        button.removeAttr('data-ajax-post');
        button.removeAttr('data-ajax-callback');
    }else {
        let templateHtml = template.html().trim();
        let dtemplateHtml = '';
        let listHtml = '';
        if (data.html.length == 0) {
            button.html(button.attr('data-lang-nomore'));
            button.removeAttr('data-ajax-params');
            button.removeAttr('data-ajax-post');
            button.removeAttr('data-ajax-callback');
        } else {
            for (let key in data.list) {
                if (data.list.hasOwnProperty(key)) {
                    for (let subkey in data.list[key]) {
                        if (data.list[key].hasOwnProperty(subkey)) {
                            dtemplateHtml = templateHtml.interpolate(data.list[key]);
                        }
                    }
                    listHtml += dtemplateHtml;
                }
            }
            container.append(listHtml);
        }
    }
}
String.prototype.interpolate = function(params) {
    // const names = Object.keys(params);
    // const vals = Object.values(params);
    // return new Function(...names, `return \`${this}\`;`)(...vals);
}
$(window).on('load',function(){
    var h, i;
    var dataValues = [];
    var svgs = document.querySelectorAll('.user_popularity_icn');
    for (i = 0; i < svgs.length; i++) {
        dataValues.push(svgs[i].dataset["value"]);
    }
    function drawcircles( ) {
        var circlelines = document.querySelectorAll('.load-circle');
        for (h = 0; h < circlelines.length; h++) {
            var totalLength = circlelines[h].getTotalLength();
            var offset = totalLength - ((dataValues[h] / 100) * totalLength);
            circlelines[h].style.transitionDuration = '1.3s';
            circlelines[h].style.strokeDashoffset = offset + "px";
        }
    }
    drawcircles();
});

$(document).ready(function(){
    $('img').bind('contextmenu', function(e){
        return false;
    }); 
});

$(document).ready(function() {
    if ($('.match_usr_img_slidr').length > 0) {
        if ($('.match_usr_img_slidr').html().trim() !== '') {
            try {
                $('.match_usr_img_slidr').carousel({
                    fullWidth: true,
                    indicators: false
                });
            } catch(e) {}
        }
    }
	
	$( document ).delegate( '[data-dismiss="modal"]', "click", function(e) {
        $('#stripe_modal').modal('close');
        $('#unlock_photo_private_stripe_modal').modal('close');
        $('#lock_pro_video_stripe_modal').modal('close');
    });
});
function Previous_Picture() {
    try {
        $('.match_usr_img_slidr').carousel('prev');
    } catch(e) {}
};
function Next_Picture() {
    try {
        $('.match_usr_img_slidr').carousel('next');
    } catch(e) {}
};
function showResponseAlert(item,alert_class,message,time = 0) {
    $(item).html('<div class="alert alert-'+alert_class+'">'+message+'</div>');
    if (time > 0) {
        setTimeout(() => {
            $(item).html('');
        },time);
    }
};
$('.to_noti_menu').dropdown({
	constrainWidth: false,
	container: '.to_hdr_noti_cont',
	'onOpenStart':function(){
		$('.to_noti_menu').addClass('active');
		$('body').addClass('notis_open');
	},
	'onCloseStart':function(){
		$('.to_noti_menu').removeClass('active');
		$('body').removeClass('notis_open');
	},
});
$('.to_hdr_noti_cont').on('click', function(event) {
    event.preventDefault();
    $('.to_noti_menu').dropdown.close();
	$('body').removeClass('notis_open');
});

$(document).ready(function(){
	$('.to_side_filters').modal({
		'onOpenEnd':function(){
			$('body').addClass('filtr_active');
		},
		'onCloseStart':function(){
			$('body').removeClass('filtr_active');
		}
	});
})

$(document).ajaxSend(function(event, jqxhr, settings) {
    console.log("AJAX-запрос:", settings.url);
});

function initSlider() {
    let slider = document.getElementById('slider1');
    if (!slider) return; // Если слайдера нет, выходим

    let track = document.getElementById('sliderTrack1');
    let startX = 0;
    let currentTranslate = 0;
    let prevTranslate = 0;
    let index = 0;
    let slides = document.querySelectorAll('.slide1');
    let totalSlides = slides.length;

    // Очищаем старые индикаторы
    const indicatorContainer = document.querySelector('.slider-indicator');
    indicatorContainer.innerHTML = '';

    // Создаём индикаторы для слайдов
    for (let i = 0; i < totalSlides; i++) {
        const indicator = document.createElement('div');
        indicatorContainer.appendChild(indicator);
    }
    let indicators = indicatorContainer.querySelectorAll('div');

    function setPosition() {
        track.style.transform = `translateX(${currentTranslate}px)`;
    }

    function updateIndicators() {
        indicators.forEach((indicator, i) => {
            indicator.classList.toggle('active', i === index);
        });
    }

    function touchStart(event) {
        startX = event.touches[0].clientX;
        prevTranslate = currentTranslate;
    }

    function touchMove(event) {
        let moveX = event.touches[0].clientX - startX;
        currentTranslate = prevTranslate + moveX;
        setPosition();
    }

    function touchEnd() {
        let moveX = currentTranslate - prevTranslate;
        if (moveX < -50 && index < totalSlides - 1) index++;
        else if (moveX > 50 && index > 0) index--;

        currentTranslate = -index * slider.clientWidth;
        setPosition();
        updateIndicators();
    }

    // Удаляем старые события (чтобы не дублировались)
    slider.removeEventListener('touchstart', touchStart);
    slider.removeEventListener('touchmove', touchMove);
    slider.removeEventListener('touchend', touchEnd);

    // Назначаем новые обработчики
    slider.addEventListener('touchstart', touchStart);
    slider.addEventListener('touchmove', touchMove);
    slider.addEventListener('touchend', touchEnd);

    // Изначально обновляем индикаторы
    updateIndicators();
}

$(document).ready(initSlider);

// Запуск после AJAX-загрузки
$(document).ajaxComplete(function() {
    initSlider();
});



//Свайп пальцем

document.addEventListener('DOMContentLoaded', function() {
    // Получаем все карточки пользователей
    const userCards = document.querySelectorAll('.userCard');

    userCards.forEach(userCard => {
        // Добавляем обработчик жестов для каждой карточки
        const hammer = new Hammer(userCard);

        // Обрабатываем свайпы влево (отказ) и вправо (согласие)
        hammer.on('swipeleft', function() {
            userCard.classList.add('swiped-left');
            setTimeout(() => {
                console.log('Свайп влево: Отклонено');
            }, 300);
        });

        

        // Обрабатываем возврат карты на место
        hammer.on('pan', function(e) {
            var moveX = e.deltaX;
            userCard.style.transform = 'translateX(' + moveX + 'px)';
        });

        hammer.on('panend', function(e) {
            if (Math.abs(e.deltaX) > 150) {
                if (e.deltaX > 0) {
                    userCard.classList.add('swiped-right');
                    console.log('Свайп вправо: Принято');
                    const userId = userCard.getAttribute('data-id'); 
                    const button = document.querySelector(`#matches_like_btn[data-userid="${userId}"]`);
                    console.log('Тест' , userId);
                    console.log('Кнопка' , button);
                    if (button) {
                        // Отправляем клик на кнопку
                        button.click();
                        console.log('Тест');

                    }
                } else {
                    userCard.classList.add('swiped-left');
                    console.log('Свайп влево: Отклонено');
                    const userId = userCard.getAttribute('data-id'); 
                    const button = document.querySelector(`#matches_dislike_btn[data-userid="${userId}"]`);
                
                    if (button) {
                    // Отправляем клик на кнопку
                    button.click();
                }
                }
            } else {
                userCard.style.transform = 'translateX(0)';
            }
        });
    });
});

