Pod::Spec.new do |s|
  s.name          = "CoreDataStack"
  s.version       = "0.0.2"
  s.summary       = "A stack for Core Data I use in my projects."
  s.license       = 'BSD'
  s.homepage      = 'https://github.com/mwildeboer/CoreDataStack'
  s.author        = { "Menno Wildeboer" => "ome.menno@gmail.com" }
  s.requires_arc  = true
  s.platform      = :ios, '5.0'
  s.source        = { :git => "https://github.com/mwildeboer/CoreDataStack.git", :tag => "0.0.2" }
  s.source_files  = 'CoreDataStack', 'CoreDataStack/**/*.{h,m}'
  s.framework     = 'CoreData'
end
