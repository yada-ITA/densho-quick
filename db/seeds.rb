# db/seeds.rb は、稼働用の仕込みデータを作成できます。
# データの作成は、ふつうに ActiveRecord の機能で行えます。
# アプリの初回セットアップ時に rake db:seed でデータを仕込みますが、念のため何
# 度も実行できるよう、データ作成前に既存データを削除しています。
# データの削除を delete_all で書いているので、取扱いにはご注意ください。。

# 部署のマスターデータ
Dept.delete_all
Dept.create([
              { name: "資材部", project: false, id: 1 },
              { name: "技術情報管理部", project: false, id: 2 },
              { name: "プロジェクトA",      project: true,   id: 3 },
              { name: "プロジェクトB",      project: true,   id: 4 },
              { name: "プロジェクトC",      project: true,   id: 5 }
            ])

# フロー順のマスターデータ
FlowOrder.delete_all
FlowOrder.create([
                   { order: 1,  project_flg: false,  dept_id: 1,   id: 1 },
                   { order: 2,  project_flg: true,  dept_id: nil, id: 2 },
                   { order: 3,  project_flg: false,   dept_id: 2,    id: 3 },
                   { order: 4,  project_flg: false,  dept_id: 1,    id: 4 }
                 ])

Flow.delete_all
Progress.delete_all
RequestApplication.delete_all
