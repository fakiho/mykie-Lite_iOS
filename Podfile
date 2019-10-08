# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def common_pods
  pod 'RealmSwift'
  pod 'CRNotifications'
end

target 'MykiLite' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MykiLite
  
  common_pods
  
  
  target 'MykiLiteTests' do
    inherit! :search_paths
    # Pods for testing
    common_pods
  end

  target 'MykiLiteUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
