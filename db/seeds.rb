# db/seeds.rb は、稼働用の仕込みデータを作成できます。
# データの作成は、ふつうに ActiveRecord の機能で行えます。
# アプリの初回セットアップ時に rake db:seed でデータを仕込みますが、念のため何
# 度も実行できるよう、データ作成前に既存データを削除しています。
# データの削除を delete_all で書いているので、取扱いにはご注意ください。。

Progress.delete_all
if Rails.env.development?
  Progress.connection.execute("update sqlite_sequence set seq=1 where name='progresses'")
else
  Progress.connection.execute("SELECT SETVAL('progresses_id_seq', 1, false)")
end


Flow.delete_all
if Rails.env.development?
  Flow.connection.execute("update sqlite_sequence set seq=1 where name='flows'")
else
  Flow.connection.execute("SELECT SETVAL('flows_id_seq', 1, false)")
end

RequestApplication.delete_all
if Rails.env.development?
  RequestApplication.connection.execute("update sqlite_sequence set seq=1 where name='request_applications'")
else
  RequestApplication.connection.execute("SELECT SETVAL('request_applications_id_seq', 1, false)")
end

FlowOrder.delete_all
Dept.delete_all

# 部署のマスターデータ
Dept.create([
              { name: "資材部", project: false, id: 1 },
              { name: "技術情報管理部", project: false, id: 2 },
              { name: "プロジェクトA",      project: true,   id: 3 },
              { name: "プロジェクトB",      project: true,   id: 4 },
              { name: "プロジェクトC",      project: true,   id: 5 }
            ])

if Rails.env.development?
  Dept.connection.execute("update sqlite_sequence set seq=5 where name='depts'")
else
  Dept.connection.execute("SELECT SETVAL('depts_id_seq', 5)")
end




# フロー順のマスターデータ
FlowOrder.create([
                   { order: 1,  project_flg: false,  dept_id: 1,  reject_permission: false, first_to_revert_permission: false, id: 1 },
                   { order: 2,  project_flg: true,  dept_id: nil, reject_permission: true,  first_to_revert_permission: false, id: 2 },
                   { order: 3,  project_flg: false,   dept_id: 2, reject_permission: true ,  first_to_revert_permission: true, id: 3 },
                   { order: 4,  project_flg: false,  dept_id: 1,  reject_permission: false , first_to_revert_permission: false, id: 4 }
                 ])

if Rails.env.development?
  FlowOrder.connection.execute("update sqlite_sequence set seq=4 where name='flow_orders'")
else
  FlowOrder.connection.execute("SELECT SETVAL('flow_orders_id_seq', 4)")
end
