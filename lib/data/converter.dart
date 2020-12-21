import 'bean/user/user_info.dart';
import 'bean/user/user_post.dart';
import 'bean/user/user_thread.dart';
import 'bean/user/post_thread.dart';
import 'bean/user/user.dart';
import 'bean/user/mentor.dart';
import 'bean/user/mentee.dart';
import 'bean/report/reports.dart';
import 'bean/report/report.dart';
import 'bean/group/group.dart';
import 'bean/group/group_info.dart';
import 'bean/group/group_users.dart';
import 'bean/other/attach_data.dart';
import 'bean/message/message.dart';
import 'bean/message/message_item.dart';
import 'bean/forum/full_forum.dart';
import 'bean/forum/post_list.dart';
import 'bean/forum/thread_list.dart';
import 'bean/forum/post_search.dart';
import 'bean/forum/post_info.dart';
import 'bean/forum/last_post_info.dart';
import 'bean/forum/thread_info.dart';
import 'bean/forum/basic_forum.dart';
import 'bean/forum/post_data.dart';
import 'bean/forum/post_search_data.dart';
import 'bean/forum/thread.dart';

class Converter {
	static getFromJson<T>(Type type, Map<String,dynamic> json) {
		switch (type) {
			case UserInfo:
				return UserInfo.fromJson(json);
			case UserPost:
				return UserPost.fromJson(json);
			case UserThread:
				return UserThread.fromJson(json);
			case PostThread:
				return PostThread.fromJson(json);
			case User:
				return User.fromJson(json);
			case Mentor:
				return Mentor.fromJson(json);
			case Mentee:
				return Mentee.fromJson(json);
			case Reports:
				return Reports.fromJson(json);
			case Report:
				return Report.fromJson(json);
			case Group:
				return Group.fromJson(json);
			case GroupInfo:
				return GroupInfo.fromJson(json);
			case GroupUsers:
				return GroupUsers.fromJson(json);
			case AttachData:
				return AttachData.fromJson(json);
			case Message:
				return Message.fromJson(json);
			case MessageItem:
				return MessageItem.fromJson(json);
			case FullForum:
				return FullForum.fromJson(json);
			case PostList:
				return PostList.fromJson(json);
			case ThreadList:
				return ThreadList.fromJson(json);
			case PostSearch:
				return PostSearch.fromJson(json);
			case PostInfo:
				return PostInfo.fromJson(json);
			case LastPostInfo:
				return LastPostInfo.fromJson(json);
			case ThreadInfo:
				return ThreadInfo.fromJson(json);
			case BasicForum:
				return BasicForum.fromJson(json);
			case PostData:
				return PostData.fromJson(json);
			case PostSearchData:
				return PostSearchData.fromJson(json);
			case Thread:
				return Thread.fromJson(json);
		}
		print('Type error! You may forgot to generate converter_gen.sh');
		return null;
	}
}
