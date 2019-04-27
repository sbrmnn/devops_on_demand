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

CertificationName.where(provider: AWS_CERT, name: 'Certified Cloud Practitioner').first_or_create
CertificationName.where(provider: AWS_CERT, name: 'Certified Developer – Associate').first_or_create
CertificationName.where(provider: AWS_CERT, name: 'Certified SysOps Administrator – Associate').first_or_create
CertificationName.where(provider: AWS_CERT, name: 'Certified Solutions Architect – Associate').first_or_create
CertificationName.where(provider: AWS_CERT, name: 'Certified DevOps Engineer – Professional').first_or_create
CertificationName.where(provider: AWS_CERT, name: 'Certified Solutions Architect – Professional').first_or_create
CertificationName.where(provider: AWS_CERT, name: 'Certified Big Data – Specialty').first_or_create
CertificationName.where(provider: AWS_CERT, name: 'Certified Advanced Networking – Specialty').first_or_create
CertificationName.where(provider: AWS_CERT, name: 'Certified Security – Specialty').first_or_create

CertificationName.where(provider: AZURE_CERT, name: 'Certified Solutions Associate (MCSA)').first_or_create
CertificationName.where(provider: AZURE_CERT, name: 'Certified Solutions Expert (MCSE)').first_or_create
CertificationName.where(provider: AZURE_CERT, name: 'Certified Solutions Developer (MCSD)').first_or_create


CertificationName.where(provider: GOOGLE_CERT, name: 'Associate Cloud Engineer').first_or_create
CertificationName.where(provider: GOOGLE_CERT, name: 'Professional Cloud Architect').first_or_create
CertificationName.where(provider: GOOGLE_CERT, name: 'Professional Data Engineer').first_or_create
CertificationName.where(provider: GOOGLE_CERT, name: 'Professional Cloud Developer').first_or_create


CSV.foreach("#{Rails.root}/public/AWSservices.csv") do |r|
  CloudService.where(provider: 'AWS', name: r ).first_or_create
end

CSV.foreach("#{Rails.root}/public/Azure.csv") do |r|
  CloudService.where(provider: 'MS Azure', name: r ).first_or_create
end

CSV.foreach("#{Rails.root}/public/GoogleServices.csv") do |r|
  CloudService.where(provider: 'Google Cloud', name: r ).first_or_create
end

CSV.foreach("#{Rails.root}/public/ProgramingLanguages.csv") do |r|
  CloudService.where(provider: 'Programing Languages', name: r ).first_or_create
end