import 'average_savings.dart';
import 'minimum_purchase.dart';
import 'store.dart';

class CouponsData {
  String? id;
  String? code;
  Store? store;
  String? title;
  String? discountType;
  num? discountValue;
  MinimumPurchase? minimumPurchase;
  List<String>? termsAndConditions;
  String? validFor;
  DateTime? startDate;
  DateTime? expiryDate;
  int? usageCount;
  num? successRate;
  AverageSavings? averageSavings;
  num? popularityScore;
  bool? isVerified;
  bool? isFeatured;
  bool? isActive;
  String? status;
  dynamic deletedAt;
  List<dynamic>? verifiedBy;
  List<dynamic>? reportedNotWorking;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? description;

  CouponsData({
    this.id,
    this.code,
    this.store,
    this.title,
    this.discountType,
    this.discountValue,
    this.minimumPurchase,
    this.termsAndConditions,
    this.validFor,
    this.startDate,
    this.expiryDate,
    this.usageCount,
    this.successRate,
    this.averageSavings,
    this.popularityScore,
    this.isVerified,
    this.isFeatured,
    this.isActive,
    this.status,
    this.deletedAt,
    this.verifiedBy,
    this.reportedNotWorking,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.description,
  });

  factory CouponsData.fromJson(Map<String, dynamic> json) => CouponsData(
        id: json['_id'] as String?,
        code: json['code'] as String?,
        store: json['store'] == null
            ? null
            : Store.fromJson(json['store'] as Map<String, dynamic>),
        title: json['title'] as String?,
        discountType: json['discount_type'] as String?,
        discountValue: json['discount_value'] == null
            ? null
            : (json['discount_value'] as num).toInt(),
        minimumPurchase: json['minimum_purchase'] == null
            ? null
            : MinimumPurchase.fromJson(
                json['minimum_purchase'] as Map<String, dynamic>),
        termsAndConditions: (json['terms_and_conditions'] as List?)
            ?.map((item) => item.toString())
            .toList(),
        validFor: json['valid_for'] as String?,
        startDate: json['start_date'] == null
            ? null
            : DateTime.parse(json['start_date'] as String),
        expiryDate: json['expiry_date'] == null
            ? null
            : DateTime.parse(json['expiry_date'] as String),
        usageCount: json['usage_count'] == null
            ? null
            : (json['usage_count'] as num).toInt(),
        successRate: json['success_rate'] == null
            ? null
            : (json['success_rate'] as num).toInt(),
        averageSavings: json['average_savings'] == null
            ? null
            : AverageSavings.fromJson(
                json['average_savings'] as Map<String, dynamic>),
        popularityScore: json['popularity_score'] == null
            ? null
            : (json['popularity_score'] as num).toInt(),
        isVerified: json['is_verified'] as bool?,
        isFeatured: json['is_featured'] as bool?,
        isActive: json['is_active'] as bool?,
        status: json['status'] as String?,
        deletedAt: json['deleted_at'],
        verifiedBy: json['verified_by'] as List<dynamic>?,
        reportedNotWorking: json['reported_not_working'] as List<dynamic>?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] == null ? null : (json['__v'] as num).toInt(),
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'code': code,
        'store': store?.toJson(),
        'title': title,
        'discount_type': discountType,
        'discount_value': discountValue,
        'minimum_purchase': minimumPurchase?.toJson(),
        'terms_and_conditions': termsAndConditions,
        'valid_for': validFor,
        'start_date': startDate?.toIso8601String(),
        'expiry_date': expiryDate?.toIso8601String(),
        'usage_count': usageCount,
        'success_rate': successRate,
        'average_savings': averageSavings?.toJson(),
        'popularity_score': popularityScore,
        'is_verified': isVerified,
        'is_featured': isFeatured,
        'is_active': isActive,
        'status': status,
        'deleted_at': deletedAt,
        'verified_by': verifiedBy,
        'reported_not_working': reportedNotWorking,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'description': description,
      };
}
