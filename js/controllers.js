var user = null, name = null;
var hospitalModule = angular.module('hospital', ['ngRoute']);

hospitalModule.config(function ($routeProvider) {
    $routeProvider
            .when('/', {
                templateUrl: 'partials/login.html',
                controller: 'LoginController'
            })
            .when('/logout', {
                templateUrl: 'partials/logout.html',
                controller: 'LogoutController'
            })
            .when('/nurse', {
                templateUrl: 'partials/nurse.html',
                controller: 'NurseController'
            })
            .when('/chemist', {
                templateUrl: 'partials/chemist.html',
                controller: 'ChemistController'
            })
            .when('/doctor', {
                templateUrl: 'partials/doctor.html',
                controller: 'DoctorController'
            })
            .when('/lab', {
                templateUrl: 'partials/lab.html',
                controller: 'LabController'
            })
            .when('/directory', {
                templateUrl: 'partials/directory.html',
                controller: 'DirectoryController'
            })
            .when('/help', {
                templateUrl: 'partials/help.html',
                controller: 'HelpController'
            })
            .when('/admin', {
                templateUrl: 'partials/admin.html',
                controller: 'AdminController'
            })
            .when('/receptionist', {
                templateUrl: 'partials/receptionist.html',
                controller: 'ReceptionistController'
            });
});

hospitalModule.controller('MainController', ['$scope', function ($scope) {
        call();
    }]);

hospitalModule.controller('AdminController', ['$scope', function ($scope) {
        $('#stats-view').hide();
        $('#disease-stats').hide();
        $scope.category = 'doctor';
        
        $.ajax({ url: 'php/admin.php', cache: false, async: false, dataType: 'json', method: 'POST',
            success: function(data) {
                $scope.info = data;
            }
        });
        $scope.staff = $scope.info.staff;
        $scope.diseases = $scope.info.diseases;
        $scope.visits = $scope.info.performance;
        var maxValue = 0, setKeys = [], setVals = [];
        
        $scope.limitValue = 1;
        $scope.change = function() {
            $scope.limitValue = -$scope.limitValue;
        };
        
        $('#stats').click(function () {
            $('#stats-view').show(300, function () {
                maxValue = 0;
                $('#period').val('yearly');
                setKeys = [];
                setVals = [];
                $.each($scope.visits.yearly, function (key, val) {
                    if(val > maxValue) {
                        maxValue = val;
                    }
                    setKeys.push(key);
                    setVals.push(val)
                });
                var plot = $.jqplot('visit_charts', [setVals], {
                    title: 'Patients visits yearly',
                    seriesDefaults: {
                        renderer: $.jqplot.BarRenderer,
                        pointLabels: {show: true},
                        pointLabels: {show: true},
                        shadowAngle: 135
                    },
                    animate: true,
                    animateReplot: true,
                    axes: {
                        yaxis: {
                            label: 'Patients',
                            min: 0,
                            max: Math.ceil(maxValue/10)*10,
                            isMinorTick: false,
                            showGridLine: false
                        },
                        xaxis: {
                            renderer: $.jqplot.CategoryAxisRenderer,
                            label: 'Years',
                            isMinorTick: false,
                            showGridLine: false,
                            ticks: setKeys
                        }
                    }
                }).replot();
            }).prev().hide(300);
        });
        $('#staff').click(function () {
            $('#staff-manage').show(300).next().hide(300);
        });
        $('#visit-part').click(function () {
            $('#visit-stats').show(function () {
                maxValue = 0;
                setKeys = [];
                setVals = [];
                $('#period').val('yearly');
                $.each($scope.visits.yearly, function (key, val) {
                    if(val > maxValue) {
                        maxValue = val;
                    }
                    setKeys.push(key);
                    setVals.push(val)
                });
                var plot = $.jqplot('visit_charts', [setVals], {
                    title: 'Patients visits yearly',
                    seriesDefaults: {
                        renderer: $.jqplot.BarRenderer,
                        pointLabels: {show: true},
                        pointLabels: {show: true},
                        shadowAngle: 135
                    },
                    animate: true,
                    animateReplot: true,
                    axes: {
                        yaxis: {
                            label: 'Patients',
                            min: 0,
                            max: Math.ceil(maxValue/10)*10,
                            isMinorTick: false,
                            showGridLine: false
                        },
                        xaxis: {
                            renderer: $.jqplot.CategoryAxisRenderer,
                            label: 'Years',
                            isMinorTick: false,
                            showGridLine: false,
                            ticks: setKeys
                        }
                    }
                }).replot();
            }).prev().hide();
        });
        $('#disease-part').click(function () {
            maxValue = 0;
            setVals = [];
            setKeys = [];
            $.each($scope.diseases, function(key, val) {
                if(val > maxValue) {
                    maxValue = val;
                }
                setVals.push(val);
                setKeys.push(key);
            });
            $('#disease-stats').show(function() {
                var plot = $.jqplot('disease-chart', [setVals], {
                    title: 'Diseases',
                    seriesDefaults: {
                        renderer: $.jqplot.BarRenderer,
                        pointLabels: {show: true},
                        pointLabels: {show: true},
                        shadowAngle: 135
                    },
                    animate: true,
                    animateReplot: true,
                    axes: {
                        yaxis: {
                            label: 'Cases',
                            min: 0,
                            max: Math.ceil(maxValue/10)*10,
                            isMinorTick: false,
                            showGridLine: false
                        },
                        xaxis: {
                            renderer: $.jqplot.CategoryAxisRenderer,
                            label: 'Diseases',
                            isMinorTick: false,
                            showGridLine: false,
                            ticks: setKeys
                        }
                    }
                }).replot();
            }).next().hide();
        });
        $('#period').on('change', function () {
            var value = $(this).val();
            maxValue = 0;
            setVals = [];
            setKeys = [];
            switch(value.toLowerCase()) {
                case 'yearly':
                    $.each($scope.visits.yearly, function (key, val) {
                        if(val > maxValue) {
                            maxValue = val;
                        }
                        setKeys.push(key);
                        setVals.push(val)
                    });
                    var plot = $.jqplot('visit_charts', [setVals], {
                        title: 'Patients visits yearly',
                        seriesDefaults: {
                            renderer: $.jqplot.BarRenderer,
                            pointLabels: {show: true},
                            pointLabels: {show: true},
                            shadowAngle: 135
                        },
                        animate: true,
                        animateReplot: true,
                        axes: {
                            yaxis: {
                                label: 'Patients',
                                min: 0,
                                max: Math.ceil(maxValue/10)*10,
                                isMinorTick: false,
                                showGridLine: false
                            },
                            xaxis: {
                                renderer: $.jqplot.CategoryAxisRenderer,
                                label: 'Years',
                                isMinorTick: false,
                                showGridLine: false,
                                ticks: setKeys
                            }
                        }
                    }).replot();
                    break;
                case 'monthly':
                    $.each($scope.visits.monthly, function(keys, vals) {
                        $.each(vals, function(key, val) {
                            $.each(val, function(k, v) {
                                if(v > maxValue) {
                                    maxValue = v;
                                }
                                setKeys.push(k + ' - ' + keys);
                                setVals.push(v);
                            });
                        });
                    });
                    var plot = $.jqplot('visit_charts', [setVals], {
                        title: 'Patients visits monthly',
                        seriesDefaults: {
                            renderer: $.jqplot.BarRenderer,
                            pointLabels: {show: true},
                            pointLabels: {show: true},
                            shadowAngle: 135
                        },
                        animate: true,
                        animateReplot: true,
                        axes: {
                            yaxis: {
                                label: 'Patients',
                                min: 0,
                                max: Math.ceil(maxValue/10)*10,
                                isMinorTick: false,
                                showGridLine: false
                            },
                            xaxis: {
                                renderer: $.jqplot.CategoryAxisRenderer,
                                label: 'Months',
                                isMinorTick: false,
                                showGridLine: false,
                                ticks: setKeys
                            }
                        }
                    }).replot();
                    break;
                case 'weekly':
                    $.each($scope.visits.weekly, function(keys, vals) {
                        $.each(vals, function(key, val) {
                            $.each(val, function(k, v) {
                                if(v > maxValue) {
                                    maxValue = v;
                                }
                                setKeys.push('Week ' + k + ' - ' + keys);
                                setVals.push(v);
                            });
                        });
                    });
                    var plot = $.jqplot('visit_charts', [setVals], {
                        title: 'Patients visits weekly',
                        seriesDefaults: {
                            renderer: $.jqplot.BarRenderer,
                            pointLabels: {show: true},
                            pointLabels: {show: true},
                            shadowAngle: 135
                        },
                        animate: true,
                        animateReplot: true,
                        axes: {
                            yaxis: {
                                label: 'Patients',
                                min: 0,
                                max: Math.ceil(maxValue/10)*10,
                                isMinorTick: false,
                                showGridLine: false
                            },
                            xaxis: {
                                renderer: $.jqplot.CategoryAxisRenderer,
                                label: 'Week number in year',
                                isMinorTick: false,
                                showGridLine: false,
                                ticks: setKeys
                            }
                        }
                    }).replot();
                    break;
                case 'daily':
                    $.each($scope.visits.daily, function(keys, vals) {
                        $.each(vals, function(key, val) {
                            $.each(val, function(k, v) {
                                if(v > maxValue) {
                                    maxValue = v;
                                }
                                setKeys.push(k + ' - ' + key + ' (' + keys + ')');
                                setVals.push(v);
                            });
                        });
                    });
                    var plot = $.jqplot('visit_charts', [setVals], {
                        title: 'Patients visits daily',
                        seriesDefaults: {
                            renderer: $.jqplot.BarRenderer,
                            pointLabels: {show: true},
                            pointLabels: {show: true},
                            shadowAngle: 135
                        },
                        animate: true,
                        animateReplot: true,
                        axes: {
                            yaxis: {
                                label: 'Patients',
                                min: 0,
                                max: Math.ceil(maxValue/10)*10,
                                isMinorTick: false,
                                showGridLine: false
                            },
                            xaxis: {
                                renderer: $.jqplot.CategoryAxisRenderer,
                                label: 'Days',
                                isMinorTick: false,
                                showGridLine: false,
                                ticks: setKeys
                            }
                        }
                    }).replot();
                    break;
            }
            
        });
    }]);

hospitalModule.controller('LogoutController', ['$scope', function ($scope) {
        $.post('php/logout.php', { }, function (data) {
            if(data == 0) {
                location.hash = '/';
                $('#logout').css('display', 'none');
                $('#name').html('Not signed in');
            }
        });
    }]);

hospitalModule.controller('LoginController', ['$scope', function ($scope) {
        call();
        $('#loginForm').submit(function () {
            var isLoginFilled = true;
            $('.loginInput').each(function () {
                if ($(this).val().trim() == "")
                    isLoginFilled = false;
            });
            var username = $('#uname').val().trim();
            var password = $('#pwd').val().trim();
            if (!isLoginFilled) {
                $('#alert-text').html('Fields cannot be empty, please ensure that all fields are filled!').parent().fadeIn(300).delay(2500).fadeOut(300);
            } else {
                $.post('php/login.php', {username: username, password: password}, function (data) {
                    if (data == 8) {
                        $('#alert-text').html('<strong>Unrecognised identity!</strong> User does not exist.').parent().fadeIn(300).delay(2500).fadeOut(300);
                    } else if (data == 9) {
                        $('#alert-text').html('<strong>Incorrect password!</strong> Please retype and try again.').parent().fadeIn(300).delay(2500).fadeOut(300);
                    } else if (data == 1 || data == 2) {
                        $('#alert-text').html('<strong>System error!</strong> Consult your system admin or come at a later time.').parent().fadeIn(300).delay(2500).fadeOut(300);
                    } else {
                        location.reload(true);
                    }
                });
            }
        });
    }]);

hospitalModule.controller('NurseController', ['$scope', '$http', function ($scope, $http) {
        call();
        $.ajax({ url: 'php/nurseWaitingList.php', cache: false, async: false, dataType: 'json',
            success: function (response) {
                if(typeof response != 'number') {
                    $scope.waitingList = response;
                } else {
                    alert('Something went wrong while fetching data');
                }
            },
            error: function () {
                alert('Fatal error encountered while attempting to fetch data');
            }
        });
        var id, logId;
        $('#nurse').on('click', '.nurseList #showModal[data-target=#clinic]', function () {
            id = $(this).val();
            logId = $(this).parent().find('.nameInNurseList').attr('id');
        });
        $('#nurse').on('click', '.nurseList #showModal[data-target=#vaccination]', function () {
            id = $(this).val();
            logId = $(this).parent().find('.nameInNurseList').attr('id');
            $.ajax({ url: 'php/vaccineDetailsList.php', cache: false, async: false, dataType: 'json', method: 'POST', data: { id: id },
                success: function (response) {
                    if(typeof response != 'number') {
                        if(response.length == 0) {
                            $('#vaccineRegistration').modal('show');
                        } else {
                            $scope.$apply(function () {
                                $scope.vaccineMeds = response;
                            });
                            
                            $('#vaccination').modal('show');
                        }
                    } else {
                        alert('Something went wrong while fetching data');
                    }
                },
                error: function (er) {
                    alert('Fatal error encountered while attempting to fetch data: ' + er.responseText);
                }
            });
        });
        $('.clinicData').submit(function (event) {
            var weight = $('#clinicInfo[name=weight]').val().trim();
            var height = $('#clinicInfo[name=height]').val().trim();
            var bp = $('#clinicInfo[name=bp]').val().trim();
            var temp = $('#clinicInfo[name=temp]').val().trim();
            var isDataFilled = true;
            
            $('#clinicInfo').each(function () {
                if ($(this).val().trim() == "") {
                    isDataFilled = false;
                }
            });
            
            if (!isDataFilled) {
                $('#forClinic').removeClass('alert-success').addClass('alert-danger').html('Please make sure all fields are filled!');
            } else if (!weight.match(/[0-9]{2}/)) {
                $('#forClinic').removeClass('alert-success').addClass('alert-danger').html('Incorrect weight input');
            } else if (!height.match(/[0-9]{2}/)) {
                $('#forClinic').removeClass('alert-success').addClass('alert-danger').html('Incorrect height input');
            } else if (!bp.match(/[0-9]{2}[/][0-9]{2}/)) {
                $('#forClinic').removeClass('alert-success').addClass('alert-danger').html('Incorrect blood pressure input');
            } else if (!temp.match(/[0-9]{2}/)) {
                $('#forClinic').removeClass('alert-success').addClass('alert-danger').html('Incorrect temperature input');
            } else {
                $.post('php/nurse.php', {weight: weight, height: height, bp: bp, temp: temp, id: id, logId: logId}, function (data) {
                    if (data == 0) {
                        $('#forClinic').removeClass('alert-danger').addClass('alert-success').html('Data successfully submitted!');
                        setTimeout(function () {
                            $('#clinic').modal('hide');
                        }, 2000);
                        location.reload(true);
                    } else {
                        $('#forClinic').removeClass('alert-success').addClass('alert-danger').html('Unexpected error while submitting data, '
                                + 'contact your administrator!');
                    }
                });
            }
            event.preventDefault();
            event.stopImmediatePropagation();
        });
        $('.vaccineData').submit(function (event) {
            var inputs = [], checked = true;
            $('input[id=check]').each(function (index) {
                if ($(this).prop('checked') == true) {
                    inputs[index] = $(this).val();
                } else {
                    checked = false;
                }
            });
            if (!checked) {
                $('#inVaccination').removeClass('alert-success').addClass('alert-danger').html('Please ensure all boxes are checked, '
                        + 'for administering full vaccination');
            } else {
                $.post('php/administerVaccine.php', { data: inputs, id: logId }, function (data) {
                    if (data == 0) {
                        $('#inVaccination').html('Successful vacccination!');
                        setTimeout(function () {
                            $('#vaccination').modal('hide');
                        }, 2000);
                        location.reload(true);
                    } else {
                        $('#inVaccination').html('Unexpected error while submitting data, contact your administrator!');
                    }
                });
            }
            event.preventDefault();
            event.stopImmediatePropagation();
        });
        var count = 0;
        $('.vaccineRegistration').submit(function (event) {
            var name = $('#vaccineInfo[name=name]').val().trim().substr(0, 1).toUpperCase() + $('#vaccineInfo[name=name]').val().trim().substr(1).toLowerCase();
            var purpose = $('#vaccineInfo[name=purpose]').val().trim().substr(0, 1).toUpperCase() + $('#vaccineInfo[name=purpose]').val().trim().substr(1).toLowerCase();
            var consumption = $('#vaccineInfo[name=consumption]').val().trim();
            var completion = $('#vaccineInfo[name=completion]').val().trim();
            var isFilled = true;
            
            $('#vaccineInfo').each(function () {
                if ($(this).val().trim() == "") {
                    isFilled = false;
                }
            });
            
            if (!isFilled) {
                $('#inVaccineRegistration').html('Please ensure all fields are filled');
            } else if(/\s/.test(name) && /\s/.test(purpose)) {
                $('#inVaccineRegistration').html('Input must not have any spaces');
            } else if (!name.match(/[a-z]+/) && !purpose.match(/[a-z]+/)) {
                $('#inVaccineRegistration').html('Invalid input detected');
            } else {
                $.post('php/vaccineRegistration.php', { id: id, name: name, purpose: purpose, consumption: consumption, completion: completion }, function (data) {
                    if (data == 0) {
                        count++;
                        $('#inVaccineRegistration').removeClass('.alert-danger').addClass('.alert-success').html('Data successfully added, total added: '
                                + count);
                    }
                });
            }
            
            event.preventDefault();
            event.stopImmediatePropagation();
        });
    }]);

hospitalModule.controller('ChemistController', ['$scope', '$http', function ($scope, $http) {
        call();
        var opened = false;
        $('#list').on('blur', '.alertInDoctor .prescription', function () {
            opened = false;
            $(this).parent().find('.prescriptionText').hide('slow', 'linear');
            $(this).parent().animate({height: 65}, 500, 'linear', function () {
                $(this).find('.prescription span').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
            });
        });
        $('#list').on('click', '.alertInDoctor .prescription', function () {
            if (!opened) {
                $(this).parent().find('.prescriptionText').show('slow', 'linear');
                $(this).parent().animate({height: 80}, 500, 'linear', function () {
                    opened = true;
                    $(this).find('.prescription span').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
                });
            } else {
                $(this).parent().find('.prescriptionText').hide('slow', 'linear');
                $(this).parent().animate({height: 65}, 500, 'linear', function () {
                    opened = false;
                    $(this).find('.prescription span').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
                });
            }
        });
        $.ajax({ url: 'php/chemistWaitingList.php', cache: false, async: false, dataType: 'json',
            success: function (response) {
                if(typeof response != 'number') {
                    $scope.waitingList = response;
                } else {
                    alert('Something went wrong while fetching data');
                }
            },
            error: function () {
                alert('Fatal error encountered while attempting to fetch data');
            }
            });
        
        $('#list').on('click', '.alertInDoctor .issue', function () {
            var id = $(this).val();
            var childId = $(this).attr('id');
            $.post('php/chemist.php', { id: id, childId: childId }, function (data) {
                if (data == 0) {
                    location.reload(true);
                } else {
                    alert(data);
                }
            });
        });
    }]);

hospitalModule.controller('LabController', ['$scope', '$http', function ($scope, $http) {
        call();
        $.ajax({ url: 'php/labPendingTests.php', cache: false, async: false, dataType: 'json',
            success: function (response) {
                if(typeof response != 'number') {
                    $scope.pending = response;
                } else {
                    alert('Something went wrong while fetching data');
                }
            },
            error: function (er) {
                alert('Fatal error encountered while attempting to fetch data');
                console.log(er.responseText);
            }
        });
        var testId;
        $('#tests').on('click', '.pendingTest .postResults', function () {
            $('.labTitle span').html($(this).parent().find('.nameInLab').html());
            testId = $(this).val();
            $('#lab').modal('show');
        });
        $('#inLab').submit(function () {
            var results = $('textarea[name=results]').val().trim();

            if (results != '') {
                $.post('php/lab.php', { results: results, testId: testId }, function (data) {
                    if (data == 5) {
                        console.log();
                        $('#infoInLab').removeClass('.alert-info').addClass('.alert-danger').html('Unexpected error while posting results');
                    } else if (data == 0) {
                        $('#infoInLab').removeClass('.alert-danger').addClass('.alert-info').html('Successful results submission');
                        setTimeout(function () {
                            $('#lab').modal('hide');
                        }, 2000);
                        location.reload(true);
                    }
                });
            } else {
                $('#infoInLab').removeClass('.alert-info').addClass('.alert-danger').html('Cannot post empty results');
            }
        });
    }]);

hospitalModule.controller('DoctorController', ['$scope', '$http', function ($scope, $http) {
        call();
        var opened = false;
        var id = 0;
        var submission = null;
        var test_id = null;
        $('.moreDetailsText').hide();
        $scope.counter = 0;
        
        $.ajax({ url: 'php/doctorWaitingLists.php', cache: false, async: false, dataType: 'json',
            success: function (response) {
                if(typeof response != 'number') {
                    $scope.data = response;
                    $scope.nurseWaiting = $scope.data.nurse;
                    $scope.labWaiting = $scope.data.lab;
                } else {
                    alert('Something went wrong while fetching data');
                }
            },
            error: function () {
                alert('Fatal error encountered while attempting to fetch data');
            }
        });
        
        $('#doctorWaitingList, #labResults').on('blur', '.alertInDoctor .moreDetails', function () {
            opened = false;
            $(this).parent().find('.moreDetailsText').hide('slow', 'linear');
            $(this).parent().animate({height: 65}, 500, 'linear', function () {
                $(this).find('.moreDetails').text('Show more details');
            });
        });
        $('#doctorWaitingList, #labResults').on('click', '.alertInDoctor .moreDetails', function (event) {
            var height = $('.moreDetailsText').outerHeight()
            if (!opened) {
                $(this).parent().find('.moreDetailsText').show('slow', 'linear');
                $(this).parent().animate({height: 65 + height}, 500, 'linear', function () {
                    opened = true;
                    $(this).find('.moreDetails').text('Hide more details');
                });
            } else {
                $(this).parent().find('.moreDetailsText').hide('slow', 'linear');
                $(this).parent().animate({height: 65}, 500, 'linear', function () {
                    opened = false;
                    $(this).find('.moreDetails').text('Show more details');
                });
            }
            event.stopImmediatePropagation();
            event.preventDefault();
        });
        $('#doctorWaitingList, #labResults').on('click', '.alertInDoctor .diagnosis', function () {
            id = $(this).val();
            test_id = $(this).parent().find('.moreDetails').val();
            submission = 'diagnosis';
            $('#drdiagname').html($(this).parent().find('.nameInDoctor').text());
            $('#diagnosis').modal('show');
        });
        $('#doctorWaitingList, #labResults').on('click', '.alertInDoctor .labRequest', function () {
            id = $(this).val();
            submission = 'tests';
            $('#labRequest').modal('show');
        });
        $('#diagnosisInDoctor').submit(function (event) {
            var diagnosis = $('input[name=diagnosis]').val().trim().substr(0, 1).toUpperCase() + $('input[name=diagnosis]').val().trim().substr(1).toLowerCase();
            var description = $('textarea[name=description]').val().trim();
            var prescription = $('textarea[name=prescription]').val().trim();
            if (diagnosis == '' && prescription == '' && description == '') {
                $('#diagnosisWarning').removeClass('.alert-info').addClass('.alert-danger').html('Please make sure all fields are filled');
            } else {
                $.post('php/doctor.php', { submission: submission, id: id, diagnosis: diagnosis, prescription: prescription, description: description, test_id: test_id },
                function (data) {
                    if (data == 0) {
                        $('#diagnosisWarning').removeClass('.alert-danger').addClass('.alert-info').html('Successful submission');
                        setTimeout(function () {
                            $('#labRequest').modal('hide');
                            location.reload(true);
                        }, 2000);
                    } else {
                        $('#diagnosisWarning').removeClass('.alert-info').addClass('.alert-danger').html('Unexpected error while submitting data');
                        console.log(data);
                    }
                });
            }
            event.preventDefault();
            event.stopImmediatePropagation();
        });
        $('#inDoctorLabRequest').submit(function (event) {
            var requestedTests = $('textarea[name=description]').val().trim();
            if (requestedTests == '') {
                $('#labWarning').removeClass('.alert-info').addClass('.alert-danger').html('Please fill out first');
            } else {
                $.post('php/doctor.php', { requestedTests: requestedTests, id: id, submission: submission }, function (data) {
                    if (data == 0) {
                        $('#labWarning').removeClass('.alert-danger').addClass('.alert-info').html('Successful submission');
                        setTimeout(function () {
                            $('#labRequest').modal('hide');
                        }, 2000);
                        location.reload(true);
                    } else {
                        $('#labWarning').removeClass('.alert-info').addClass('.alert-danger').html('Unexpected error while submitting data');
                    }
                });
            }
            event.preventDefault();
            event.stopImmediatePropagation();
        });
    }]);

hospitalModule.controller('ReceptionistController', ['$scope', '$http', function ($scope, $http) {
        call();
        $.ajax({ url: 'php/patientsList.php', cache: false, async: false, dataType: 'json',
            success: function (response) {
                if(typeof response != 'number') {
                    $scope.patients = response;
                    $scope.recentPatients = $scope.patients.new;
                    $scope.allPatients = $scope.patients.all;
                } else {
                    alert('Something went wrong while fetching data');
                }
            },
            error: function (er) {
                alert('Fatal error encountered while attempting to fetch data');
            }
        });
        $('#existingPatientView').on("click", ".existingPatient", function (event) {
            var id = $(this).val();
            $.post('php/existingVisit.php', {id: id}, function (data) {
                if (data == 0) {
                    $('#inExisting').removeClass('.alert-danger').addClass('.alert-info').html('Successful submission');
                    setTimeout(function () {
                        $('#existing').modal('hide');
                    }, 1000);
                    location.reload(true);
                } else {
                    $('#inExisting').removeClass('.alert-info').addClass('.alert-danger').html('Error during submission');
                }
            });
            event.preventDefault();
            event.stopImmediatePropagation();
        });
        $('.personalData').submit(function (event) {
            console.log('submitted');
            var isPersonalFilled = true;
            $('#personalInfo').each(function () {
                if ($(this).val().trim() == "") {
                    isPersonalFilled = false;
                }
            });
            var childFname = $('#personalInfo[name=cfname]').val().trim().substr(0, 1).toUpperCase() + $('#personalInfo[name=cfname]').val().trim().substr(1).toLowerCase();
            var childSname = $('#personalInfo[name=csname]').val().trim().substr(0, 1).toUpperCase() + $('#personalInfo[name=csname]').val().trim().substr(1).toLowerCase();
            var childSurname = $('#personalInfo[name=csurname]').val().trim().substr(0, 1).toUpperCase() + $('#personalInfo[name=csurname]').val().trim().substr(1).toLowerCase();
            var childDOB = $('#personalInfo[name=dob]').val().trim();
            var childGender = $('#personalInfo[name=gender]').val();
            var guardianFname = $('#personalInfo[name=fname]').val().trim().substr(0, 1).toUpperCase() + $('#personalInfo[name=fname]').val().trim().substr(1).toLowerCase();
            var guardianSurname = $('#personalInfo[name=surname]').val().trim().substr(0, 1).toUpperCase() + $('#personalInfo[name=surname]').val().trim().substr(1).toLowerCase();
            if (!isPersonalFilled) {
                $('#personalAlert').html('<strong>Empty fields! </strong>All fields must be filled.');
            } else if (!childDOB.match(/(19|20[0-9]{2})[-](0[1-9]|1[0-2])[-](0[1-9]|[12][0-9]|3[01])/)) {
                $('#personalAlert').html('<strong>Incorrect date format! </strong>Please use yyyy-mm-dd format');
            } else if (/\s/.test(childFname) && /\s/.test(childSname) && /\s/.test(childSurname) && /\s/.test(guardianFname) && /\s/.test(guardianSurname)) {
                $('#personalAlert').html('<strong>Name fields error!</strong> Ensure no spaces in name fields.');
            } else {
                $.post('php/register.php', {childFname: childFname, childSname: childSname, childSurname: childSurname, childDOB: childDOB,
                    childGender: childGender, guardianFname: guardianFname, guardianSurname: guardianSurname}, function (data) {
                    if (data != 0) {
                        $('#personalAlert').html('<strong>System Error! </strong>Contact your system administrator.');
                    } else {
                        $('#personalAlert').removeClass('alert-danger').addClass('alert-success').html('Data successfully submitted!');
                        setTimeout(function () {
                            $('#add').modal('hide');
                        }, 2000);
                        location.reload(true);
                    }
                });
            }
            event.preventDefault();
            event.stopImmediatePropagation();
        });
    }]);

function call () {
    $.post('php/session.php', { }, function (data) {
        if (data == 7) {
            location.hash = '/';
            $('#name').html('Not signed in');
            $('#logout').hide();
        } else {
            var obj = JSON.parse(data);
            name = obj.name;
            user = obj.role;
            $('#name').html(name);
            location.hash = '/' + user;
        }
    });
}