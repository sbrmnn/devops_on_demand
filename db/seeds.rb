# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AWS = 'AWS'
AZURE = 'MS Azure'
GOOGLE = 'Google'

CertificationName.first_or_create(provider: AWS, name: 'Certified Cloud Practitioner')
CertificationName.first_or_create(provider: AWS, name: 'Certified Developer – Associate')
CertificationName.first_or_create(provider: AWS, name: 'Certified SysOps Administrator – Associate')
CertificationName.first_or_create(provider: AWS, name: 'Certified Solutions Architect – Associate')
CertificationName.first_or_create(provider: AWS, name: 'Certified DevOps Engineer – Professional')
CertificationName.first_or_create(provider: AWS, name: 'Certified Solutions Architect – Professional')
CertificationName.first_or_create(provider: AWS, name: 'Certified Big Data – Specialty')
CertificationName.first_or_create(provider: AWS, name: 'Certified Advanced Networking – Specialty')