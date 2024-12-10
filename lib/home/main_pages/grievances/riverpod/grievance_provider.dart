import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/studentwise_grievance_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';

class GrievanceProvider extends StateNotifier<GrievanceState> {
  GrievanceProvider() : super(GrievanceInitial());

  void disposeState() => state = GrievanceInitial();

  void _setLoading() => state = GrievanceStateLoading(
        successMessage: '',
        errorMessage: '',
        grievanceCaregoryData: <GrievanceCategoryHiveData>[],
        grievanceSubType: <GrievanceSubTypeHiveData>[],
        grievanceType: <GrievanceTypeHiveData>[],
        selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
        selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
        selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
        description: TextEditingController(),
        studentId: TextEditingController(),
        studentname: TextEditingController(),
        subject: TextEditingController(),
        studentwisegrievanceData: <StudentWiseHiveData>[],
      );

  Future<void> getGrievanceCategoryDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );

    final response =
        await HttpService.sendSoapRequest('getGrievanceCategory', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableGrievance(
        successMessage: '',
        errorMessage: '',
        grievanceCaregoryData: <GrievanceCategoryHiveData>[],
        grievanceSubType: state.grievanceSubType,
        grievanceType: state.grievanceType,
        selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
        selectedgrievanceSubTypeDataList:
            state.selectedgrievanceSubTypeDataList,
        selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
        description: TextEditingController(),
        studentId: TextEditingController(),
        studentname: TextEditingController(),
        subject: TextEditingController(),
        studentwisegrievanceData: state.studentwisegrievanceData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final grievanceCaregoryRes =
          details['getGrievanceCategoryResponse'] as Map<String, dynamic>;
      final returnData = grievanceCaregoryRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        // var grievanceCaregoryData = state.grievanceCaregoryData;
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        if (listData.isNotEmpty) {
          // final grievanceCaregoryDataResponse =
          //     GrievanceCategory.fromJson(decryptedData.mapData!);
          // grievanceCaregoryData = grievanceCaregoryDataResponse.data!;
          // state = state.copyWith(grievanceCaregoryData: grievanceCaregoryData);
          final box = await Hive.openBox<GrievanceCategoryHiveData>(
            'grievanceCategoryData',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = GrievanceCategoryHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = GrievanceCategoryHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = GrievanceStateError(
            successMessage: '',
            errorMessage: error.message!,
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceSubType: state.grievanceSubType,
            grievanceType: state.grievanceType,
            selectedgrievanceCaregoryDataList:
                state.selectedgrievanceCaregoryDataList,
            selectedgrievanceSubTypeDataList:
                state.selectedgrievanceSubTypeDataList,
            selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
            description: TextEditingController(),
            studentId: TextEditingController(),
            studentname: TextEditingController(),
            subject: TextEditingController(),
            studentwisegrievanceData: state.studentwisegrievanceData,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = GrievanceStateError(
          successMessage: '',
          errorMessage:
              '''${decryptedData.mapData!['Status']}, ${decryptedData.mapData!['Message']}''',
          grievanceCaregoryData: <GrievanceCategoryHiveData>[],
          grievanceSubType: state.grievanceSubType,
          grievanceType: state.grievanceType,
          selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
          selectedgrievanceSubTypeDataList:
              state.selectedgrievanceSubTypeDataList,
          selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
          description: TextEditingController(),
          studentId: TextEditingController(),
          studentname: TextEditingController(),
          subject: TextEditingController(),
          studentwisegrievanceData: state.studentwisegrievanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = GrievanceStateError(
        successMessage: '',
        errorMessage: 'error',
        grievanceCaregoryData: <GrievanceCategoryHiveData>[],
        grievanceSubType: state.grievanceSubType,
        grievanceType: state.grievanceType,
        selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
        selectedgrievanceSubTypeDataList:
            state.selectedgrievanceSubTypeDataList,
        selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
        description: TextEditingController(),
        studentId: TextEditingController(),
        studentname: TextEditingController(),
        subject: TextEditingController(),
        studentwisegrievanceData: state.studentwisegrievanceData,
      );
    }
  }

  Future<void> getHiveGrievanceCategoryDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<GrievanceCategoryHiveData>(
        'grievanceCategoryData',
      );
      final grievanceCategoryHiveData = <GrievanceCategoryHiveData>[
        ...box.values,
      ];

      state = state.copyWith(grievanceCaregoryData: grievanceCategoryHiveData);
      await box.close();
    } catch (e) {
      await getHiveGrievanceCategoryDetails(search);
    }
  }

  void setValue(GrievanceCategoryHiveData data) {
    state = state.copyWith(
      selectedgrievanceCaregoryDataList: data,
    );
  }

  Future<void> getGrievanceSubTypeDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getGrievanceSubType', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableGrievance(
        successMessage: '',
        errorMessage: '',
        grievanceSubType: <GrievanceSubTypeHiveData>[],
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceType: state.grievanceType,
        selectedgrievanceCaregoryDataList:
            state.selectedgrievanceCaregoryDataList,
        selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
        selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
        description: TextEditingController(),
        studentId: TextEditingController(),
        studentname: TextEditingController(),
        subject: TextEditingController(),
        studentwisegrievanceData: state.studentwisegrievanceData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final grievanceSubTypeRes =
          details['getGrievanceSubTypeResponse'] as Map<String, dynamic>;
      final returnData = grievanceSubTypeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        // var grievanceSubType = state.grievanceSubType;
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        if (listData.isNotEmpty) {
          //   final grievanceSubTypeCResponse =
          //       GrievanceSubTypeModel.fromJson(decryptedData.mapData!);
          //   grievanceSubType = grievanceSubTypeCResponse.data!;
          //   state = state.copyWith(grievanceSubType: grievanceSubType);
          final box = await Hive.openBox<GrievanceSubTypeHiveData>(
            'grievanceSubTypeData',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = GrievanceSubTypeHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = GrievanceSubTypeHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = GrievanceStateError(
            successMessage: '',
            errorMessage: error.message!,
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceSubType: <GrievanceSubTypeHiveData>[],
            grievanceType: state.grievanceType,
            selectedgrievanceCaregoryDataList:
                state.selectedgrievanceCaregoryDataList,
            selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
            selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
            description: TextEditingController(),
            studentId: TextEditingController(),
            studentname: TextEditingController(),
            subject: TextEditingController(),
            studentwisegrievanceData: state.studentwisegrievanceData,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = GrievanceStateError(
          successMessage: '',
          errorMessage:
              '''${decryptedData.mapData!['Status']}, ${decryptedData.mapData!['Message']}''',
          grievanceCaregoryData: state.grievanceCaregoryData,
          grievanceSubType: <GrievanceSubTypeHiveData>[],
          grievanceType: state.grievanceType,
          selectedgrievanceCaregoryDataList:
              state.selectedgrievanceCaregoryDataList,
          selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
          selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
          description: TextEditingController(),
          studentId: TextEditingController(),
          studentname: TextEditingController(),
          subject: TextEditingController(),
          studentwisegrievanceData: state.studentwisegrievanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = GrievanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceSubType: <GrievanceSubTypeHiveData>[],
        grievanceType: state.grievanceType,
        selectedgrievanceCaregoryDataList:
            state.selectedgrievanceCaregoryDataList,
        selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
        selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
        description: TextEditingController(),
        studentId: TextEditingController(),
        studentname: TextEditingController(),
        subject: TextEditingController(),
        studentwisegrievanceData: state.studentwisegrievanceData,
      );
    }
  }

  Future<void> getHiveGrievanceSubTypeDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<GrievanceSubTypeHiveData>(
        'grievanceSubTypeData',
      );
      final grievanceCategoryHiveData = <GrievanceSubTypeHiveData>[
        ...box.values,
      ];

      state = state.copyWith(grievanceSubType: grievanceCategoryHiveData);
      await box.close();
    } catch (e) {
      await getHiveGrievanceSubTypeDetails(search);
    }
  }

  void setsubtype(GrievanceSubTypeHiveData data) {
    state = state.copyWith(
      selectedgrievanceSubTypeDataList: data,
    );
  }

  Future<void> getGrievanceTypeDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getGrievanceType', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableGrievance(
        successMessage: '',
        errorMessage: '',
        grievanceSubType: state.grievanceSubType,
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceType: <GrievanceTypeHiveData>[],
        selectedgrievanceCaregoryDataList:
            state.selectedgrievanceCaregoryDataList,
        selectedgrievanceSubTypeDataList:
            state.selectedgrievanceSubTypeDataList,
        selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
        description: TextEditingController(),
        studentId: TextEditingController(),
        studentname: TextEditingController(),
        subject: TextEditingController(),
        studentwisegrievanceData: state.studentwisegrievanceData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final grievanceTypeRes =
          details['getGrievanceTypeResponse'] as Map<String, dynamic>;
      final returnData = grievanceTypeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        if (listData.isNotEmpty) {
          // var grievanceType = state.grievanceType;

          final box = await Hive.openBox<GrievanceTypeHiveData>(
            'grievanceTypeData',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = GrievanceTypeHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = GrievanceTypeHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();
          // try {
          //   final grievanceTypeCResponse =
          //       GrievanceTypeModel.fromJson(decryptedData.mapData!);
          //   grievanceType = grievanceTypeCResponse.data!;
          //   state = state.copyWith(grievanceType: grievanceType);
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = GrievanceStateError(
            successMessage: '',
            errorMessage: error.message!,
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceSubType: state.grievanceSubType,
            grievanceType: <GrievanceTypeHiveData>[],
            selectedgrievanceCaregoryDataList:
                state.selectedgrievanceCaregoryDataList,
            selectedgrievanceSubTypeDataList:
                state.selectedgrievanceSubTypeDataList,
            selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
            description: TextEditingController(),
            studentId: TextEditingController(),
            studentname: TextEditingController(),
            subject: TextEditingController(),
            studentwisegrievanceData: state.studentwisegrievanceData,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = GrievanceStateError(
          successMessage: '',
          errorMessage:
              '''${decryptedData.mapData!['Status']}, ${decryptedData.mapData!['Message']}''',
          grievanceCaregoryData: state.grievanceCaregoryData,
          grievanceSubType: state.grievanceSubType,
          grievanceType: <GrievanceTypeHiveData>[],
          selectedgrievanceCaregoryDataList:
              state.selectedgrievanceCaregoryDataList,
          selectedgrievanceSubTypeDataList:
              state.selectedgrievanceSubTypeDataList,
          selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
          description: TextEditingController(),
          studentId: TextEditingController(),
          studentname: TextEditingController(),
          subject: TextEditingController(),
          studentwisegrievanceData: state.studentwisegrievanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = GrievanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceSubType: state.grievanceSubType,
        grievanceType: <GrievanceTypeHiveData>[],
        selectedgrievanceCaregoryDataList:
            state.selectedgrievanceCaregoryDataList,
        selectedgrievanceSubTypeDataList:
            state.selectedgrievanceSubTypeDataList,
        selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
        description: TextEditingController(),
        studentId: TextEditingController(),
        studentname: TextEditingController(),
        subject: TextEditingController(),
        studentwisegrievanceData: state.studentwisegrievanceData,
      );
    }
  }

  Future<void> getHiveGrievanceTypeDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<GrievanceTypeHiveData>(
        'grievanceTypeData',
      );
      final grievanceTypeHiveData = <GrievanceTypeHiveData>[
        ...box.values,
      ];

      state = state.copyWith(grievanceType: grievanceTypeHiveData);
      await box.close();
    } catch (e) {
      await getHiveGrievanceTypeDetails(search);
    }
  }

  void settype(GrievanceTypeHiveData data) {
    state = state.copyWith(
      selectedgrievanceTypeDataList: data,
    );
  }

  Future<void> saveGrievanceDetails(EncryptionProvider encrypt) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><grievancetypeid>${state.selectedgrievanceTypeDataList.grievancetypeid}</grievancetypeid><grievancecatid>${state.selectedgrievanceCaregoryDataList.grievancekcategoryid}</grievancecatid><grievancesubcatid>${state.selectedgrievanceSubTypeDataList.grievancesubcategoryid}</grievancesubcatid><subject>${state.subject.text}</subject><username>${TokensManagement.studentName}</username><subjectdesc>${state.description.text}</subjectdesc>',
    );
    final response = await HttpService.sendSoapRequest('saveGrievance', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableGrievance(
        successMessage: '',
        errorMessage: '',
        grievanceSubType: state.grievanceSubType,
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceType: state.grievanceType,
        selectedgrievanceCaregoryDataList:
            state.selectedgrievanceCaregoryDataList,
        selectedgrievanceSubTypeDataList:
            state.selectedgrievanceSubTypeDataList,
        selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
        description: state.description,
        studentId: state.studentId,
        studentname: state.studentname,
        subject: state.subject,
        studentwisegrievanceData: state.studentwisegrievanceData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final saveGrievanceRes =
          details['saveGrievanceResponse'] as Map<String, dynamic>;
      final returnData = saveGrievanceRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      if (decryptedData.mapData!['Status'] == 'Success') {
        state = GrievanceStateSuccessful(
          successMessage: '${decryptedData.mapData!['Status']}',
          errorMessage: '',
          grievanceCaregoryData: state.grievanceCaregoryData,
          grievanceSubType: state.grievanceSubType,
          grievanceType: state.grievanceType,
          selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
          selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
          selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
          description: TextEditingController(),
          studentId: TextEditingController(),
          studentname: TextEditingController(),
          subject: TextEditingController(),
          studentwisegrievanceData: state.studentwisegrievanceData,
        );
      } else {
        state = GrievanceStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          grievanceSubType: state.grievanceSubType,
          grievanceCaregoryData: state.grievanceCaregoryData,
          grievanceType: state.grievanceType,
          selectedgrievanceCaregoryDataList:
              state.selectedgrievanceCaregoryDataList,
          selectedgrievanceSubTypeDataList:
              state.selectedgrievanceSubTypeDataList,
          selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
          description: state.description,
          studentId: state.studentId,
          studentname: state.studentname,
          subject: state.subject,
          studentwisegrievanceData: state.studentwisegrievanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = GrievanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        grievanceSubType: state.grievanceSubType,
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceType: state.grievanceType,
        selectedgrievanceCaregoryDataList:
            state.selectedgrievanceCaregoryDataList,
        selectedgrievanceSubTypeDataList:
            state.selectedgrievanceSubTypeDataList,
        selectedgrievanceTypeDataList: state.selectedgrievanceTypeDataList,
        description: state.description,
        studentId: state.studentId,
        studentname: state.studentname,
        subject: state.subject,
        studentwisegrievanceData: state.studentwisegrievanceData,
      );
    }
  }

  Future<void> getStudentWiseGrievanceDetails(
    EncryptionProvider encrypt,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getStudentWiseGrievances', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableGrievance(
        successMessage: '',
        errorMessage: '',
        grievanceSubType: state.grievanceSubType,
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceType: state.grievanceType,
        selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
        selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
        selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
        description: TextEditingController(),
        studentId: TextEditingController(),
        studentname: TextEditingController(),
        subject: TextEditingController(),
        studentwisegrievanceData: <StudentWiseHiveData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final studetwisegrievanceTypeRes =
          details['getStudentWiseGrievancesResponse'] as Map<String, dynamic>;
      final returnData =
          studetwisegrievanceTypeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        // var studentwisegrievanceData = state.studentwisegrievanceData;
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        if (listData.isNotEmpty) {
          final box = await Hive.openBox<StudentWiseHiveData>(
            'studentWiseHiveData',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = StudentWiseHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = StudentWiseHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();

          // try {
          //   final studetwisegrievanceResponse =
          //       GetStudentWiseGrievancesMmodel.fromJson(decryptedData.mapData!);
          //   studentwisegrievanceData = studetwisegrievanceResponse.data!;
          //   state =
          //       state.copyWith(studentwisegrievanceData: studentwisegrievanceData);
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = GrievanceStateError(
            successMessage: '',
            errorMessage: error.message!,
            grievanceSubType: state.grievanceSubType,
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceType: state.grievanceType,
            selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
            selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
            selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
            description: TextEditingController(),
            studentId: TextEditingController(),
            studentname: TextEditingController(),
            subject: TextEditingController(),
            studentwisegrievanceData: <StudentWiseHiveData>[],
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = GrievanceStateError(
          successMessage: '',
          errorMessage:
              '''${decryptedData.mapData!['Status']}, ${decryptedData.mapData!['Message']}''',
          grievanceSubType: state.grievanceSubType,
          grievanceCaregoryData: state.grievanceCaregoryData,
          grievanceType: state.grievanceType,
          selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
          selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
          selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
          description: TextEditingController(),
          studentId: TextEditingController(),
          studentname: TextEditingController(),
          subject: TextEditingController(),
          studentwisegrievanceData: <StudentWiseHiveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = GrievanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        grievanceSubType: state.grievanceSubType,
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceType: state.grievanceType,
        selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
        selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
        selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
        description: TextEditingController(),
        studentId: TextEditingController(),
        studentname: TextEditingController(),
        subject: TextEditingController(),
        studentwisegrievanceData: <StudentWiseHiveData>[],
      );
    }
  }

  Future<void> getHiveGrievanceDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<StudentWiseHiveData>(
        'studentWiseHiveData',
      );
      final grievanceHiveData = <StudentWiseHiveData>[
        ...box.values,
      ];

      state = state.copyWith(studentwisegrievanceData: grievanceHiveData);
      await box.close();
    } catch (e) {
      await getHiveGrievanceDetails(search);
    }
  }
}
