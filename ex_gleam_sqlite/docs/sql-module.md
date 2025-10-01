# sql.gleam モジュール使用方法

`src/db/sql.gleam` は parrot によって自動生成されたSQLクエリモジュールです。このモジュールはTodoアプリケーションのデータベース操作を型安全に実行するための関数とデコーダーを提供します。

## 概要

このモジュールは以下の2つのテーブルに対する操作を提供します：
- `todos`: TODOアイテムを管理
- `todo_categories`: TODOカテゴリを管理

## 基本的な使い方

各クエリ関数は以下の形式で結果を返します：
```gleam
#(sql, parameters, decoder)
```

- `sql`: 実行するSQLクエリ文字列
- `parameters`: パラメータのリスト
- `decoder`: 結果をGleamの型にデコードする関数

## カテゴリ操作 (todo_categories)

### 1. カテゴリの作成
```gleam
import db/sql

// カテゴリを新規作成
let create_query = sql.create_category(name: "Work", color: option.Some("#3B82F6"))
// 戻り値の型: CreateCategory
```

### 2. カテゴリの取得
```gleam
// IDでカテゴリを取得
let get_query = sql.get_category(id: 1)
// 戻り値の型: GetCategory

// 名前でカテゴリを取得
let get_by_name_query = sql.get_category_by_name(name: "Work")
// 戻り値の型: GetCategoryByName
```

### 3. カテゴリ一覧の取得
```gleam
// 全カテゴリを名前順で取得
let list_query = sql.list_categories()
// 戻り値の型: ListCategories
```

### 4. カテゴリの更新
```gleam
// カテゴリを更新
let update_query = sql.update_category(
  name: "Updated Work", 
  color: option.Some("#FF0000"), 
  id: 1
)
// 戻り値の型: UpdateCategory
```

### 5. カテゴリの削除
```gleam
// カテゴリを削除
let delete_query = sql.delete_category(id: 1)
// 戻り値: #(sql, [parameters])
```

## TODO操作 (todos)

### 1. TODOの作成
```gleam
import gleam/time/timestamp
import gleam/option

// 新しいTODOを作成
let create_query = sql.create_todo(
  title: "Complete project",
  description: option.Some("Finish the web application"),
  completed: False,
  priority: 5,
  due_date: option.Some(timestamp.now()),
  category_id: option.Some(1)
)
// 戻り値の型: CreateTodo
```

### 2. TODOの取得
```gleam
// IDでTODOを取得（カテゴリ情報含む）
let get_query = sql.get_todo(id: 1)
// 戻り値の型: GetTodo（category_name, category_colorも含む）
```

### 3. TODO一覧の取得

#### 全TODO一覧
```gleam
// 全TODOを作成日時降順で取得
let list_query = sql.list_todos()
// 戻り値の型: ListTodos
```

#### カテゴリ別TODO一覧
```gleam
// 特定カテゴリのTODOを取得
let category_list_query = sql.list_todos_by_category(category_id: option.Some(1))
// 戻り値の型: ListTodosByCategory
```

#### 完了状態別TODO一覧
```gleam
// 未完了のTODOを取得（優先度と作成日時で並び替え）
let pending_query = sql.list_todos_by_completed(completed: False)
// 戻り値の型: ListTodosByCompleted
```

#### 優先度別TODO一覧
```gleam
// 優先度3以上のTODOを取得
let priority_query = sql.list_todos_by_priority(priority: 3)
// 戻り値の型: ListTodosByPriority
```

#### 期限が近いTODO一覧
```gleam
// 7日以内に期限が来る未完了TODOを取得
let due_soon_query = sql.list_todos_due_soon()
// 戻り値の型: ListTodosDueSoon
```

### 4. TODOの更新

#### 完全更新
```gleam
// TODOの全フィールドを更新
let update_query = sql.update_todo(
  title: "Updated title",
  description: option.Some("Updated description"),
  completed: True,
  priority: 4,
  due_date: option.None,
  category_id: option.Some(2),
  id: 1
)
// 戻り値の型: UpdateTodo
```

#### 完了状態のみ更新
```gleam
// 完了状態のみを更新
let status_query = sql.update_todo_status(completed: True, id: 1)
// 戻り値の型: UpdateTodoStatus
```

#### 優先度のみ更新
```gleam
// 優先度のみを更新
let priority_query = sql.update_todo_priority(priority: 5, id: 1)
// 戻り値の型: UpdateTodoPriority
```

#### カテゴリのみ更新
```gleam
// カテゴリのみを更新
let category_query = sql.update_todo_category(category_id: option.Some(3), id: 1)
// 戻り値の型: UpdateTodoCategory
```

### 5. TODOの削除
```gleam
// 特定のTODOを削除
let delete_query = sql.delete_todo(id: 1)

// 完了したTODOを全て削除
let delete_completed_query = sql.delete_completed_todos()
```

### 6. TODO検索
```gleam
// タイトルと説明でTODOを検索
let search_query = sql.search_todos(
  title: "%project%",
  description: option.Some("%web%")
)
// 戻り値の型: SearchTodos
```

## 統計・集計機能

### 1. TODO数のカウント
```gleam
// 全TODO数を取得
let count_query = sql.count_todos()
// 戻り値の型: CountTodos

// 完了状態別TODO数を取得
let status_count_query = sql.count_todos_by_status(completed: False)
// 戻り値の型: CountTodosByStatus

// カテゴリ別TODO数を取得
let category_count_query = sql.count_todos_by_category(category_id: option.Some(1))
// 戻り値の型: CountTodosByCategory
```

### 2. TODO統計情報
```gleam
// 総合統計を取得（総数、完了数、未完了数、期限切れ数）
let stats_query = sql.get_todo_stats()
// 戻り値の型: GetTodoStats
```

## 型定義

### 共通フィールド
- `id: Int` - レコードの一意識別子
- `created_at: Timestamp` - 作成日時
- `updated_at: Timestamp` - 更新日時（TODOのみ）

### カテゴリ型
- `name: String` - カテゴリ名
- `color: Option(String)` - カテゴリ色（16進数色コード）

### TODO型
- `title: String` - TODOタイトル
- `description: Option(String)` - 説明（オプション）
- `completed: Bool` - 完了状態
- `priority: Int` - 優先度（1-5）
- `due_date: Option(Timestamp)` - 期限日時（オプション）
- `category_id: Option(Int)` - カテゴリID（オプション）

### 拡張TODO型（JOIN結果）
一部のクエリでは以下のフィールドが追加されます：
- `category_name: Option(String)` - カテゴリ名
- `category_color: Option(String)` - カテゴリ色

## 注意事項

1. **自動生成コード**: このファイルはparrotによって自動生成されているため、直接編集しないでください。
2. **型安全性**: 全ての関数は型安全で、コンパイル時にSQLエラーを検出できます。
3. **NULL値**: データベースのNULL値は `Option` 型で表現されます。
4. **パラメータ化クエリ**: SQLインジェクション攻撃を防ぐため、全てのクエリはパラメータ化されています。

## 使用例

```gleam
import db/sql
import gleam/option

// カテゴリ作成
let category_query = sql.create_category(
  name: "Personal", 
  color: option.Some("#10B981")
)

// TODO作成
let todo_query = sql.create_todo(
  title: "Buy groceries",
  description: option.Some("Milk, bread, eggs"),
  completed: False,
  priority: 2,
  due_date: option.None,
  category_id: option.Some(1)
)

// 未完了TODOの取得
let pending_todos = sql.list_todos_by_completed(completed: False)

// 統計情報の取得
let stats = sql.get_todo_stats()
```