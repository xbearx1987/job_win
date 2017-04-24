# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

locations = Location.create([{ name: '北京' }, { name: '上海' }, { name: '深圳' }, { name: '广州' }, { name: '杭州' }, { name: '成都' }, { name: '香港' }, { name: '海外' }, { name: '南京', is_hidden: true }, { name: '苏州', is_hidden: true }])
