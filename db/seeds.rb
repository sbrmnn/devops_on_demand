# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AWS_CERT = 'AWS'
AZURE_CERT = 'MS Azure'
GOOGLE_CERT = 'Google'

CertificationName.first_or_create(provider: AWS_CERT, name: 'Certified Cloud Practitioner')
CertificationName.first_or_create(provider: AWS_CERT, name: 'Certified Developer – Associate')
CertificationName.first_or_create(provider: AWS_CERT, name: 'Certified SysOps Administrator – Associate')
CertificationName.first_or_create(provider: AWS_CERT, name: 'Certified Solutions Architect – Associate')
CertificationName.first_or_create(provider: AWS_CERT, name: 'Certified DevOps Engineer – Professional')
CertificationName.first_or_create(provider: AWS_CERT, name: 'Certified Solutions Architect – Professional')
CertificationName.first_or_create(provider: AWS_CERT, name: 'Certified Big Data – Specialty')
CertificationName.first_or_create(provider: AWS_CERT, name: 'Certified Advanced Networking – Specialty')
CertificationName.first_or_create(provider: AWS_CERT, name: 'Certified Security – Specialty')

CertificationName.first_or_create(provider: AZURE_CERT, name: 'Certified Solutions Associate (MCSA)')
CertificationName.first_or_create(provider: AZURE_CERT, name: 'Certified Solutions Expert (MCSE)')
CertificationName.first_or_create(provider: AZURE_CERT, name: 'Certified Solutions Developer (MCSD)')


CertificationName.first_or_create(provider: GOOGLE_CERT, name: 'Associate Cloud Engineer')
CertificationName.first_or_create(provider: GOOGLE_CERT, name: 'Professional Cloud Architect')
CertificationName.first_or_create(provider: GOOGLE_CERT, name: 'Professional Data Engineer')
CertificationName.first_or_create(provider: GOOGLE_CERT, name: 'Professional Cloud Developer')