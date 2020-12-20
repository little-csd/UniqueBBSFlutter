import 'bean/user/user_info.dart';
import 'bean/user/user.dart';
import 'bean/user/mentor.dart';
import 'bean/user/mentee.dart';
import 'bean/report/reports.dart';
import 'bean/report/report.dart';
import 'bean/group/group.dart';
import 'bean/group/group_info.dart';
import 'bean/group/group_users.dart';
import 'bean/forum/full_forum.dart';
import 'bean/forum/post_info.dart';
import 'bean/forum/last_post.dart';
import 'bean/forum/threads.dart';
import 'bean/forum/thread_info.dart';
import 'bean/forum/basic_forum.dart';
import 'bean/forum/post.dart';
import 'bean/forum/posts.dart';

class Converter {
	static getFromJson<T>(Type type, Map<String,dynamic> json) {
		switch (type) {
			case UserInfo:
				return UserInfo.fromJson(json);
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
			case FullForum:
				return FullForum.fromJson(json);
			case PostInfo:
				return PostInfo.fromJson(json);
			case LastPost:
				return LastPost.fromJson(json);
			case Threads:
				return Threads.fromJson(json);
			case ThreadInfo:
				return ThreadInfo.fromJson(json);
			case BasicForum:
				return BasicForum.fromJson(json);
			case Post:
				return Post.fromJson(json);
			case Posts:
				return Posts.fromJson(json);
		}
		return null;
	}
}
