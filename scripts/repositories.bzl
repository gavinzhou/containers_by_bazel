load(
  "//scripts/versions:versions.bzl",
  "ELASTICSEARCH_VERSION",
  "GRAFANA_VERSION",
  "JASPERREPORTS_SERVER_VERSION",
  "JASPERSOFT_STUDIO_VERSION",
  "JENKINS_VERSION",
  "JENKINS_SWARM_VERSION",
  "KAFKA_VERSION",
  "KIBANA_VERSION",
  "MAVEN_VERSION",
  "NEXUS_VERSION",
  "PENATHO_DI_VERSION",
  "PROMETHEUS_VERSION",
  "ZOOKEEPER_VERSION"
)
load("//deps/jessie:jessie.bzl", "deb_jessie")
load("//deps/stretch:stretch.bzl", "deb_stretch")

def dependency_repositories():
  native.git_repository(
    name = "bazel_rules_container",
    remote = "https://github.com/guymers/bazel_rules_container.git",
    tag = "0.2.1",
  )

  # 2016-09-19 debootstraps
  native.http_file(
    name = "debian_jessie",
    url = "https://raw.githubusercontent.com/tianon/docker-brew-debian/261f8d1fd3b61f1f790c1f47b006ca150064189b/jessie/rootfs.tar.xz",
    sha256 = "02dbf76511e00408fedd9c109b824140002e5b2bfbb0d3a2dd03ad265b4e867e",
  )
  # 2016-09-19 debootstraps
  native.http_file(
    name = "debian_stretch",
    url = "https://raw.githubusercontent.com/tianon/docker-brew-debian/5262a068af848af6e4084a1853999f4df1d68a2a/stretch/rootfs.tar.xz",
    sha256 = "777f32f5164180e1bb99c9258339f8d1d5d8eafb43b69f8a24fbd8404a6be42a",
  )

  deb_jessie()
  deb_stretch()

  native.http_file(
    name = "gosu",
    url = "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64",
    executable = 1,
    sha256 = "34049cfc713e8b74b90d6de49690fa601dc040021980812b2f1f691534be8a50",
  )

  native.http_file(
    name = "tini",
    url = "https://github.com/krallin/tini/releases/download/v0.9.0/tini_0.9.0.deb",
    sha256 = "21a2d4436e9fd12248bbcc5d881ca7815f35e836e1c9f6595a7c490fd2e6bc0f",
  )

  native.new_http_archive(
    name = "prometheus",
    url = "https://github.com/prometheus/prometheus/releases/download/v" + PROMETHEUS_VERSION + "/prometheus-" + PROMETHEUS_VERSION + ".linux-amd64.tar.gz",
    sha256 = "46c8aa0fe71d2a484d7b393d2c420b21ad849a129eac66fc740283e3c8377f85",
    strip_prefix = "prometheus-" + PROMETHEUS_VERSION + ".linux-amd64",
    build_file_content = "exports_files(['prometheus'])",
  )

  native.new_http_archive(
    name = "prometheus_node_exporter",
    url = "https://github.com/prometheus/node_exporter/releases/download/0.12.0/node_exporter-0.12.0.linux-amd64.tar.gz",
    sha256 = "d48de5b89dac04aca751177afaa9b0919e5b3d389364d40160babc00d63aac7b",
    strip_prefix = "node_exporter-0.12.0.linux-amd64",
    build_file_content = "exports_files(['node_exporter'])",
  )

  native.maven_jar(
    name = "jmx_prometheus_javaagent",
    artifact = "io.prometheus.jmx:jmx_prometheus_javaagent:0.6",
    sha1 = "19e9c04f88c8af71054d91045bb9c720adc8ac58",
  )


  native.new_http_archive(
    name = "sbt",
    url = "https://dl.bintray.com/sbt/native-packages/sbt/0.13.11/sbt-0.13.11.tgz",
    sha256 = "a36a6fbf6dd70afd93fb8db16c40e8ac00798fdddfa0b4c678786dc15617afa6",
    build_file_content = "exports_files(['sbt'])",
  )
  native.http_file(
    name = "sbt_ivy_cache",
    url = "https://raw.githubusercontent.com/guymers/sbt-ivy-cache/master/sbt-0.13.11-ivy-cache.tar",
    sha256 = "e9e1596d5c141f2b946442260e7bb412405e6af70316ee8f8e0fe87635cb5996",
  )

  native.new_http_archive(
    name = "nexus",
    url = "https://download.sonatype.com/nexus/oss/nexus-" + NEXUS_VERSION + "-bundle.tar.gz",
    sha256 = "4c4e88a2410e1740e688ea1ab3c6066a6a90f76c479e10e4718c517a27f3a614",
    build_file_content = "exports_files(['nexus-" + NEXUS_VERSION + "'])",
  )
  native.new_http_archive(
    name = "nexus3",
    url = "http://download.sonatype.com/nexus/3/nexus-3.0.0-03-unix.tar.gz",
    sha256 = "0666769effc200a520825cce22d59a5a296d03795f72f57d0a97fbe61836d0ca",
    build_file_content = "exports_files(['nexus-3.0.0-03'])",
  )


  ###### JENKINS
  native.http_file(
    name = "jenkins_war",
    url = "http://mirrors.jenkins-ci.org/war-stable/" + JENKINS_VERSION + "/jenkins.war",
    sha256 = "32e07928198e065965e598ab5a655e2d21be2407873ce2533d0edb58aa1a369a",
  )
  native.http_file(
    name = "jenkins_agent_jar",
    url = "http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/" + JENKINS_SWARM_VERSION + "/swarm-client-" + JENKINS_SWARM_VERSION + "-jar-with-dependencies.jar",
    sha256 = "fc5ad10aaca1a3563c1ec650ad9bcb8ecbea0be9cd10053421f89647daeef8eb",
  )

  ###### MAVEN
  native.new_http_archive(
    name = "maven",
    url = "http://mirrors.ocf.berkeley.edu/apache/maven/maven-3/" + MAVEN_VERSION + "/binaries/apache-maven-" + MAVEN_VERSION + "-bin.tar.gz",
    sha256 = "6e3e9c949ab4695a204f74038717aa7b2689b1be94875899ac1b3fe42800ff82",
    build_file_content = "exports_files(['apache-maven-" + MAVEN_VERSION + "'])",
  )

  ###### ZOOKEEPER
  native.new_http_archive(
    name = "zookeeper",
    url = "http://mirrors.ocf.berkeley.edu/apache/zookeeper/zookeeper-" + ZOOKEEPER_VERSION + "/zookeeper-" + ZOOKEEPER_VERSION + ".tar.gz",
    sha256 = "f10a0b51f45c4f64c1fe69ef713abf9eb9571bc7385a82da892e83bb6c965e90",
    build_file_content = "exports_files(['zookeeper-" + ZOOKEEPER_VERSION + "'])",
  )

  ###### KAFKA
  native.new_http_archive(
    name = "kafka",
    url = "http://mirrors.ocf.berkeley.edu/apache/kafka/" + KAFKA_VERSION + "/kafka_2.11-" + KAFKA_VERSION + ".tgz",
    sha256 = "2d73625aeddd827c9e92eefb3c727a78455725fbca4361c221eaa05ae1fab02d",
    build_file_content = "exports_files(['kafka_2.11-" + KAFKA_VERSION + "'])",
  )

  ###### ELASTICSEARCH
  # cannot use the deb file because it contains two copies of lib/elasticsearch-2.3.5.jar
  native.new_http_archive(
    name = "elasticsearch",
    url = "https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/" + ELASTICSEARCH_VERSION + "/elasticsearch-" + ELASTICSEARCH_VERSION + ".tar.gz",
    sha256 = "3ae01140ae7bcbb91436feef381fbed774e36ef6d1e8e6a3153640db82acf4c9",
    build_file_content = "exports_files(['elasticsearch-" + ELASTICSEARCH_VERSION + "'])",
  )

  ###### KIBANA
  native.new_http_archive(
    name = "kibana",
    url = "https://download.elastic.co/kibana/kibana/kibana-" + KIBANA_VERSION + "-linux-x86_64.tar.gz",
    sha256 = "2cc005b7bfbe2436f4cf93fcdb957ab5683e7d7843537dfd2bd51644c835dcaf",
    build_file_content = "exports_files(['kibana-" + KIBANA_VERSION + "-linux-x86_64'])",
  )


  ###### TOMCAT
  native.http_file(
    name = "tomcat_sample_war",
    url = "https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war",
    sha256 = "89b33caa5bf4cfd235f060c396cb1a5acb2734a1366db325676f48c5f5ed92e5",
  )

  ###### JASPER
  native.new_http_archive(
    name = "jasper_server",
    url = "http://downloads.sourceforge.net/project/jasperserver/JasperServer/JasperReports%20Server%20Community%20Edition%20" + JASPERREPORTS_SERVER_VERSION + "/jasperreports-server-cp-" + JASPERREPORTS_SERVER_VERSION + "-bin.zip",
    sha256 = "f7d7f7e3be7a6d01c5c00386978402665ee3a01c9f013fe8ac37c569dba43350",
    strip_prefix = "jasperreports-server-cp-" + JASPERREPORTS_SERVER_VERSION + "-bin",
    build_file_content = "exports_files([ \
      'jasperserver.war', \
      'apache-ant', \
      'buildomatic', \
    ])"
  )
  native.maven_jar(
    name = "postgresql_driver",
    artifact = "org.postgresql:postgresql:9.4.1208",
    sha1 = "5c7e80698b80a5045fe64daa67426051bbd16a56",
  )

  native.new_http_archive(
    name = "jasper_client",
    url = "http://downloads.sourceforge.net/project/jasperstudio/JaspersoftStudio-" + JASPERSOFT_STUDIO_VERSION + "/TIBCOJaspersoftStudio-" + JASPERSOFT_STUDIO_VERSION + ".final-linux-x86_64.tgz",
    sha256 = "b43a4ee5ddf8a1f192ea4e268b389c2b766f9a6fbd5ef58e6bbef9f2cdf73b7e",
    build_file_content = "exports_files(['TIBCOJaspersoftStudio-" + JASPERSOFT_STUDIO_VERSION + ".final'])",
  )

  native.new_http_archive(
    name = "pentaho_data_integration",
    url = "http://downloads.sourceforge.net/project/pentaho/Data%20Integration/6.1/pdi-ce-" + PENATHO_DI_VERSION + ".zip",
    sha256 = "ef5076c09e8481d1ab4cfc5f7d4701437f80f2b97a3bf19dfa74821de9524495",
    build_file_content = "exports_files(['data-integration'])",
  )
