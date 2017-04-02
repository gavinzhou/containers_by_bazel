NGINX_VERSION = "1.11.11-1"
NGINX_DEB_VERSION = NGINX_VERSION + "~jessie"

NODEJS_VERSION = "6.10.1-2"
NODEJS_DEB_VERSION = NODEJS_VERSION + "nodesource1~jessie1"
YARN_VERSION = "0.21.3"

ZULU_VERSION = "8.20.0.5"

ZOOKEEPER_VERSION = "3.4.9"
KAFKA_VERSION = "0.10.1.1"

ELASTICSEARCH_VERSION = "5.2.2"

KIBANA_VERSION = "5.2.2"

SBT_VERSION = "0.13.13"

POSTGRESQL_MINOR_VERSION = "9.6"
POSTGRESQL_VERSION = POSTGRESQL_MINOR_VERSION + "." + "2-1"
POSTGRESQL_DEB_VERSION = POSTGRESQL_VERSION + "." + "pgdg80+1"
POSTGIS_MINOR_VERSION = "2.3"
POSTGIS_VERSION = POSTGIS_MINOR_VERSION + "." + "2"
POSTGIS_CONTAINER_VERSION = POSTGRESQL_VERSION + "-" + POSTGIS_VERSION
POSTGIS_DEB_VERSION = POSTGIS_VERSION + "+dfsg-1~exp2.pgdg80+1"
POSTGIS_POSTGRESQL_DEB_VERSION = POSTGIS_DEB_VERSION

REDIS_VERSION = "3.2.8-2"
REDIS_DEB_VERSION = REDIS_VERSION + "~bpo8+1"

TOMCAT7_VERSION = "7.0.56-3"
TOMCAT7_DEB_VERSION = TOMCAT7_VERSION + "+deb8u7"

MAVEN_VERSION = "3.3.9"

PHP_VERSION = "7.0.16-3"

PROMETHEUS_VERSION = "1.5.2"

GRAFANA_VERSION = "4.1.2"
GRAFANA_DEB_VERSION = GRAFANA_VERSION + "-1486989747"

NEXUS_VERSION = "2.14.3-02"

GERRIT_VERSION = "2.13.6-1"
GERRIT_DEB_VERSION = GERRIT_VERSION

DNSMASQ_VERSION = "2.72-3"
DNSMASQ_DEB_VERSION = DNSMASQ_VERSION + "+deb8u1"

ERLANG_VERSION = "19.2.1"
ERLANG_DEB_VERSION = ERLANG_VERSION + "+dfsg-2~bpo8+1"

RABBITMQ_VERSION = "3.6.9-1"

POLIPO_VERSION = "1.1.1-5"

JENKINS_VERSION = "2.32.3"
JENKINS_SWARM_VERSION = "2.2"

JASPERSOFT_STUDIO_VERSION = "6.2.2"
JASPERREPORTS_SERVER_VERSION = "6.2.1"

PENATHO_DI_VERSION = "6.1.0.1-196"

def _version_shell_script_impl(ctx):
  # (.+)=(%\{.+\})   =>   "$2": $1,
  ctx.template_action(
    template=ctx.file._template,
    substitutions={
      "%{NGINX_VERSION}": NGINX_VERSION,
      "%{NGINX_DEB_VERSION}": NGINX_DEB_VERSION,
      "%{NODEJS_VERSION}": NODEJS_VERSION,
      "%{NODEJS_DEB_VERSION}": NODEJS_DEB_VERSION,
      "%{YARN_VERSION}": YARN_VERSION,
      "%{ZULU_VERSION}": ZULU_VERSION,
      "%{ZOOKEEPER_VERSION}": ZOOKEEPER_VERSION,
      "%{KAFKA_VERSION}": KAFKA_VERSION,
      "%{ELASTICSEARCH_VERSION}": ELASTICSEARCH_VERSION,
      "%{SBT_VERSION}": SBT_VERSION,
      "%{POSTGRESQL_MINOR_VERSION}": POSTGRESQL_MINOR_VERSION,
      "%{POSTGRESQL_VERSION}": POSTGRESQL_VERSION,
      "%{POSTGRESQL_DEB_VERSION}": POSTGRESQL_DEB_VERSION,
      "%{POSTGIS_MINOR_VERSION}": POSTGIS_MINOR_VERSION,
      "%{POSTGIS_VERSION}": POSTGIS_VERSION,
      "%{POSTGIS_CONTAINER_VERSION}": POSTGIS_CONTAINER_VERSION,
      "%{POSTGIS_DEB_VERSION}": POSTGIS_DEB_VERSION,
      "%{POSTGIS_POSTGRESQL_DEB_VERSION}": POSTGIS_POSTGRESQL_DEB_VERSION,
      "%{REDIS_VERSION}": REDIS_VERSION,
      "%{REDIS_DEB_VERSION}": REDIS_DEB_VERSION,
      "%{TOMCAT7_VERSION}": TOMCAT7_VERSION,
      "%{TOMCAT7_DEB_VERSION}": TOMCAT7_DEB_VERSION,
      "%{MAVEN_VERSION}": MAVEN_VERSION,
      "%{PHP_VERSION}": PHP_VERSION,
      "%{PROMETHEUS_VERSION}": PROMETHEUS_VERSION,
      "%{GRAFANA_VERSION}": GRAFANA_VERSION,
      "%{GRAFANA_DEB_VERSION}": GRAFANA_DEB_VERSION,
      "%{NEXUS_VERSION}": NEXUS_VERSION,
      "%{GERRIT_VERSION}": GERRIT_VERSION,
      "%{GERRIT_DEB_VERSION}": GERRIT_DEB_VERSION,
      "%{DNSMASQ_VERSION}": DNSMASQ_VERSION,
      "%{DNSMASQ_DEB_VERSION}": DNSMASQ_DEB_VERSION,
      "%{ERLANG_VERSION}": ERLANG_VERSION,
      "%{ERLANG_DEB_VERSION}": ERLANG_DEB_VERSION,
      "%{RABBITMQ_VERSION}": RABBITMQ_VERSION,
      "%{POLIPO_VERSION}": POLIPO_VERSION,
      "%{JENKINS_VERSION}": JENKINS_VERSION,
      "%{JENKINS_SWARM_VERSION}": JENKINS_SWARM_VERSION,
      "%{JASPERSOFT_STUDIO_VERSION}": JASPERSOFT_STUDIO_VERSION,
      "%{JASPERREPORTS_SERVER_VERSION}": JASPERREPORTS_SERVER_VERSION,
      "%{PENATHO_DI_VERSION}": PENATHO_DI_VERSION,
    },
    output=ctx.outputs.script
  )

version_shell_script = rule(
  implementation=_version_shell_script_impl,
  attrs={
    "_template": attr.label(
      default=Label("//scripts/versions:template"),
      single_file=True,
      allow_files=True)
  },
  outputs={
    "script": "%{name}.sh"
  },
)
