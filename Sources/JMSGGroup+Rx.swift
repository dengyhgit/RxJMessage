//
//  JMSGGroup+Rx.swift
//  RxJMessage
//
//  Created by 邓永豪 on 2018/3/14.
//  Copyright © 2018年 dengyonghao. All rights reserved.
//

import Foundation
import JMessage
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

extension Reactive where Base: JMSGGroup {

    public static func create(name: String?, desc: String, members: [String]?) -> Observable<JMSGGroup> {
        return Observable.create({ observer in
            JMSGGroup.createGroup(withName: name, desc: desc, memberArray: members, completionHandler: { (result, error) in
                if let group = result as? JMSGGroup {
                    observer.onNext(group)
                }
                if let error = error {
                    observer.onError(error)
                }
            })
            return Disposables.create()
        })
    }

    public static func create(groupInfo: JMSGGroupInfo, members: [String]?) -> Observable<JMSGGroup> {
        return Observable.create({ observer in
            JMSGGroup.createGroup(with: groupInfo, memberArray: members, completionHandler: { (result, error) in
                if let group = result as? JMSGGroup {
                    observer.onNext(group)
                }
                if let error = error {
                    observer.onError(error)
                }
            })
            return Disposables.create()
        })
    }

    static func update(groupId: String, name: String?, desc: String?) -> Observable<Void> {
        return Observable.create({ observer in
            JMSGGroup.updateGroupInfo(withGroupId: groupId, name: name, desc: desc, completionHandler: { (result, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        })
    }

    public static func groupInfo(_ groupId: String) -> Observable<JMSGGroup> {
        return Observable.create({ observer in
            JMSGGroup.groupInfo(withGroupId: groupId) { (result, error) in
                if let group = result as? JMSGGroup {
                    observer.onNext(group)
                }
                if let error = error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })

    }
//
//    /*!
//     * @abstract 更新群信息（统一字段上传）
//     *
//     * @param gid         群组 id
//     * @param groupInfo   群信息类，详细请查看 JMSGGroupInfo 类
//     * @param handler     结果回调. 正常返回时, resultObject 为 nil.
//     *
//     * @discussion 注意：修改群名称和群描述时参数不允许传空字符串，群类型不允许修改
//     */
//    + (void)updateGroupInfoWithGid:(NSString *)gid
//    groupInfo:(JMSGGroupInfo *)groupInfo
//    completionHandler:(JMSGCompletionHandler JMSG_NULLABLE)handler;
//
//    /*!
//     * @abstract 更新群头像（支持传图片格式）
//     *
//     * @param groupId         待更新的群组ID
//     * @param avatarData      头像数据
//     * @param avatarFormat    头像格式，可以为空，不包括"."
//     * @param handler         回调
//     *
//     * @discussion 头像格式参数直接填格式名称，不要带点。正确：@"png"，错误：@".png"
//     */
//    + (void)updateGroupAvatarWithGroupId:(NSString *JMSG_NONNULL)groupId
//    avatarData:(NSData *JMSG_NONNULL)avatarData
//    avatarFormat:(NSString *JMSG_NULLABLE)avatarFormat
//    completionHandler:(JMSGCompletionHandler JMSG_NULLABLE)handler;
//
//    /*!
//     * @abstract 获取群组信息
//     *
//     * @param groupId 待获取详情的群组ID
//     * @param handler 结果回调. 正常返回时 resultObject 类型是 JMSGGroup.
//     *
//     * @discussion 该接口总是向服务器端发起请求, 即使本地已经存在.
//     * 如果考虑性能损耗, 在群聊时获取群组信息, 可以获取 JMSGConversation -> target 属性.
//     */
//    + (void)groupInfoWithGroupId:(NSString *)groupId
//    completionHandler:(JMSGCompletionHandler)handler;
//
//    /*!
//     * @abstract 获取我的群组列表
//     *
//     * @param handler 结果回调。正常返回时 resultObject 的类型是 NSArray，数组里的成员类型是JMSGGroup的gid
//     *
//     * @discussion 该接口总是向服务器端发起请求。
//     */
//    + (void)myGroupArray:(JMSGCompletionHandler)handler;
//
//    /*!
//     * @abstract 获取所有设置群消息屏蔽的群组
//     *
//     * @param handler 结果回调。回调参数：
//     *
//     * - resultObject 类型为 NSArray，数组里成员的类型为 JMSGGroup
//     * - error 错误信息
//     *
//     * 如果 error 为 nil, 表示设置成功
//     * 如果 error 不为 nil,表示设置失败
//     *
//     * @discussion 从服务器获取，返回所有设置群消息屏蔽的群组。
//     */
//    + (void)shieldList:(JMSGCompletionHandler)handler;
//
//    /*!
//     * @abstract 分页获取 appkey 下所有公开群信息
//     *
//     * @param appkey    群组所在的 AppKey，不填则默认为当前应用 AppKey
//     * @param start     分页获取的下标，第一页从  index = 0 开始
//     * @param count     每一页的数量，最大值为500
//     * @param handler   结果回调，NSArray<JMSGGroupInfo>
//     *
//     * #### 注意：
//     *
//     * 返回数据中不是 JMSGGroup 类型，而是 JMSGGroupInfo 类型，只能用于展示信息，如果想要调用相关群组 API 接口则需要通过 gid 获取到 JMSGGroup 对象才可以调用
//     */
//    + (void)getPublicGroupInfoWithAppKey:(NSString *JMSG_NULLABLE)appkey
//    start:(NSInteger)start
//    count:(NSInteger)count
//    completionHandler:(JMSGCompletionHandler)handler;
//
//    /*!
//     * @abstract 申请加入群组
//     *
//     * @param gid     群组 gid
//     * @param reason   申请原因
//     * @param handler 结果回调
//     *
//     * @discussion 只有公开群需要申请才能加入，私有群不需要申请。
//     */
//    + (void)applyJoinGroupWithGid:(NSString *JMSG_NONNULL)gid
//    reason:(NSString *JMSG_NULLABLE)reason
//    completionHandler:(JMSGCompletionHandler)handler;
//
//    /*!
//     * @abstract 管理员审批入群申请
//     *
//     * @patam eventId     入取申请事件的 id，详情请查看 JMSGApplyJoinGroupEvent 类
//     * @param gid         群组 gid
//     * @param joinUser    入群的用户
//     * @param applyUser   发起申请的的用户，如果是主动申请入群则和 member 是相同的
//     * @param isAgree     是否同意申请，YES : 同意， NO: 不同意
//     * @param reason      拒绝申请的理由，选填
//     * @param handler     结果回调
//     *
//     * @discussion 只有管理员才有权限审批入群申请，SDK 不会保存申请入群事件(JMSGApplyJoinGroupEvent)，上层可以自己封装再保存，或则归档直接保存，以便此接口取值调用。
//     */
//    + (void)processApplyJoinGroupEventID:(NSString *JMSG_NONNULL)eventId
//    gid:(NSString *JMSG_NONNULL)gid
//    joinUser:(JMSGUser *JMSG_NONNULL)joinUser
//    applyUser:(JMSGUser *JMSG_NONNULL)applyUser
//    isAgree:(BOOL)isAgree
//    reason:(NSString *JMSG_NULLABLE)reason
//    handler:(JMSGCompletionHandler)handler;
//    /*!
//     * @abstract 解散群组
//     *
//     * @patam gid     需要解散的群组 id
//     * @param handler 结果回调,error = nil 表示操作成功
//     *
//     * @discussion 只有群主才有权限解散群。
//     */
//    + (void)dissolveGroupWithGid:(NSString *)gid handler:(JMSGCompletionHandler)handler;
}

