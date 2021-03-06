# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixUeberauthComeonin.Repo.insert!(%PhoenixUeberauthComeonin.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PhoenixUeberauthComeonin.Repo

Repo.insert! %User{
  name: "Administrator",
  email: "admin@admin.com",
  password: Comeonin.Bcrypt.hashpwsalt("admin")
}
