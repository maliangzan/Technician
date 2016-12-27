//
//  HYHttpRequest.h
//  smanos
//
//  Created by sven on 3/17/16.
//  Copyright © 2016 sven. All rights reserved.
//

#ifndef HYHttpRequest_h
#define HYHttpRequest_h


//UIB URL
#define kBaseUIBURL @"http://dcuib001.dreamcatcher-cloud.net"
//PSB URL
#define KBasePSBURL @"http://dcpsb001.dreamcatcher-cloud.net:18081/psb/userReg"



#define kWaitTips @"Please wait..."

//snapshot path
#define kSnapshotPath [NSString stringWithFormat:@"%@/%@/%@", [HYAPPTool documentPath], @"snapshots",[[UserInfo sharedInstance] email]]

//video path
#define kVideoRecordPath [NSString stringWithFormat:@"%@/%@/%@", [HYAPPTool documentPath], @"records",[[UserInfo sharedInstance] email]]

//portrait path
#define kPortraitPath [NSString stringWithFormat:@"%@/%@", [HYAPPTool documentPath], @"portrait.png"]

#define kURLAlarmCount @"http://history.goolink.org:8080/storageweb/GetAlarmCountReq.jsp"  //GetTotalCount]报警列表总数据
#define kURLAlarmIds @"http://history.goolink.org:8080/storageweb/GetAlarmInfoReq.jsp" //AlarmList 报警列表IDs数据]
#define kURLAlarmInfos @"http://history.goolink.org:8080/storageweb/DownFileInfoReq.jsp" //AlarmListItemInfos 报警列表详细数据


#define kTestDeviceID @"ABCDEFGHIJKLMNOPQR08"
#define kCompanyID @"LT4a7a46c6bb6d5"
#define kGID  [[[HYDeviceTool sharedHYDeviceTool] currentDevice] device_id]
#define kGUsername [[[HYDeviceTool sharedHYDeviceTool] currentDevice] device_username]
#define kGPassword [[[HYDeviceTool sharedHYDeviceTool] currentDevice] device_password]

#define kPSBUrlUserSub @"https://54.213.68.8:18080/psb/userSub"
#define kPSBServerAddress @"54.213.68.8"
#define kPSBServerPort 1882
#define kDIBServerPort 1883

#define kAccountNickName @"kAccountNickName"
//notice
#define kNotice_update_portrait @"notice_updatePortrait"
#define kNotice_update_nickName @"notice_updateNickName"

/**
 *  invalied status
 */
#define kInvaliedDeviceStatus (-10)


#endif /* HYHttpRequest_h */
