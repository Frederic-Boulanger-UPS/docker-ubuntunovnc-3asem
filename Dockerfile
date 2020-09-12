FROM fredblgr/ubuntu-novnc:20.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y gcc ocaml menhir \
  libnum-ocaml-dev libzarith-ocaml-dev libzip-ocaml-dev \
  libmenhir-ocaml-dev liblablgtk3-ocaml-dev liblablgtksourceview3-ocaml-dev \
  libocamlgraph-ocaml-dev libre-ocaml-dev libjs-of-ocaml-dev
# RUN apt-get install -y coqide alt-ergo cvc4 gedit wget
RUN apt-get install -y coqide alt-ergo gedit wget

# Not done because we use the SMT solvers bundled with Isabelle
# Install Z3 4.8.6
# RUN wget https://github.com/Z3Prover/z3/archive/z3-4.8.6.tar.gz \
#   && tar zxf z3-4.8.6.tar.gz \
#   && cd z3-z3-4.8.6; ./configure; cd build; make; make install
# RUN rm -r z3-*

# Install E prover
# RUN wget http://wwwlehre.dhbw-stuttgart.de/~sschulz/WORK/E_DOWNLOAD/V_2.4/E.tgz \
#   && tar zxf E.tgz \
#   && cd E; ./configure --prefix=/usr/local; make; make install
# RUN rm -r E E.tgz

# Install Isabelle 2019
ARG ISATARGZ=Isabelle2019_linux.tar.gz
ARG ISAINSTDIR=Isabelle2019
ARG ISABIN=isabelle2019
ARG ISADESKTOP=resources/Isabelle2019.desktop
ARG ISAPREFS=resources/dot_isabelle_2019
ARG ISAHEAPSDIR=Isabelle2019/heaps/polyml-5.8_x86_64_32-linux
ARG ISAJDK=/usr/local/Isabelle2019/contrib/jdk-11.0.3+7/x86_64-linux
RUN wget https://isabelle.in.tum.de/website-Isabelle2019/dist/${ISATARGZ} \
  && tar -xzf ${ISATARGZ} \
  && mv ${ISAINSTDIR} /usr/local/ \
  && ln -s /usr/local/${ISAINSTDIR}/bin/isabelle /usr/local/bin/${ISABIN} \
  && ln -s /usr/local/bin/${ISABIN} /usr/local/bin/isabelle \
  && ln -s /usr/local/${ISAINSTDIR}/contrib/cvc4-1.5-5/x86_64-linux/cvc4 /usr/local/bin/cvc4 \
  && ln -s /usr/local/${ISAINSTDIR}/contrib/e-2.0-2/x86_64-linux/eprover /usr/local/bin/eprover \
  && ln -s /usr/local/${ISAINSTDIR}/contrib/spass-3.8ds-1/x86_64-linux/SPASS /usr/local/bin/SPASS \
  && ln -s /usr/local/${ISAINSTDIR}/contrib/vampire-4.2.2/x86_64-linux/vampire /usr/local/bin/vampire \
  && ln -s /usr/local/${ISAINSTDIR}/contrib/z3-4.4.0pre-3/x86_64-linux/z3 /usr/local/bin/z3
RUN rm ${ISATARGZ}
COPY ${ISADESKTOP} /usr/share/applications/
COPY ${ISAPREFS} /root/.isabelle
RUN echo 'cp -r /root/.isabelle ${HOME}' >> /root/.novnc_setup
RUN ln -s ${ISAJDK}/bin/java /usr/local/bin/ ; \
    ln -s ${ISAJDK}/bin/javac /usr/local/bin/

# # Install Isabelle 2020
# ARG ISATARGZ=Isabelle2020_linux.tar.gz
# ARG ISAINSTDIR=Isabelle2020
# ARG ISABIN=isabelle2020
# ARG ISADESKTOP=resources/Isabelle2020.desktop
# ARG ISAPREFS=resources/dot_isabelle_2020
# RUN wget https://isabelle.in.tum.de/dist/${ISATARGZ} \
#   && tar -xzf ${ISATARGZ} \
#   && mv ${ISAINSTDIR} /usr/local/ \
#   && ln -s /usr/local/${ISAINSTDIR}/bin/isabelle /usr/local/bin/${ISABIN} \
#   && ln -s /usr/local/bin/${ISABIN} /usr/local/bin/isabelle \
#   && ln -s /usr/local/${ISAINSTDIR}/contrib/cvc4-1.5-5/x86_64-linux/cvc4 /usr/local/bin/cvc4 \
#   && ln -s /usr/local/${ISAINSTDIR}/contrib/e-2.0-3/x86_64-linux/eprover /usr/local/bin/eprover \
#   && ln -s /usr/local/${ISAINSTDIR}/contrib/spass-3.8ds-1/x86_64-linux/SPASS /usr/local/bin/SPASS \
#   && ln -s /usr/local/${ISAINSTDIR}/contrib/vampire-4.2.2/x86_64-linux/vampire /usr/local/bin/vampire \
#   && ln -s /usr/local/${ISAINSTDIR}/contrib/z3-4.4.0pre-3/x86_64-linux/z3 /usr/local/bin/z3
# RUN rm ${ISATARGZ}
# COPY ${ISADESKTOP} /usr/share/applications/
# COPY resources/isabelle_properties /root/.isabelle/Isabelle2020/jedit/properties
# RUN echo 'cp -r /root/.isabelle ${HOME}' >> /root/.novnc_setup

# # Install Why3
# RUN wget https://gforge.inria.fr/frs/download.php/file/38291/why3-1.3.1.tar.gz \
#   && tar zxf why3-1.3.1.tar.gz \
#   && cd why3-1.3.1; ./configure; make ; \
#      make install \
#   && why3 config --detect-provers && mv /home/ubuntu/.why3.conf /root/ ;\
#   cd ..; rm -r why3-1.3.1
# RUN echo 'cp /root/.why3.conf ${HOME}' >> /root/.novnc_setup

# Install Why3 1.3.1 when working with Isabelle
# RUN wget https://gforge.inria.fr/frs/download.php/file/38291/why3-1.3.1.tar.gz \
#   && tar zxf why3-1.3.1.tar.gz \
#   && cd why3-1.3.1; ./configure; make ; \
#      echo "/usr/local/lib/why3/isabelle" >> /usr/local/${ISAINSTDIR}/etc/components ; \
#      make install \
#   && mv /home/ubuntu/.isabelle/${ISAHEAPSDIR}/HOL-Word \
#         /usr/local/${ISAHEAPSDIR}/ \
#   && mv /home/ubuntu/.isabelle/${ISAHEAPSDIR}/Why3 \
#         /usr/local/${ISAHEAPSDIR}/ \
#   && mv /home/ubuntu/.isabelle/${ISAHEAPSDIR}/log/* \
#         /usr/local/${ISAHEAPSDIR}/log/ \
#   && why3 config --detect-provers && mv /home/ubuntu/.why3.conf /root/ ;\
#   cd ..; rm -r why3-1.3.1

# Install Why3 1.3.3 when working with Isabelle
RUN wget https://gforge.inria.fr/frs/download.php/file/38367/why3-1.3.3.tar.gz \
  && tar zxf why3-1.3.3.tar.gz \
  && cd why3-1.3.3; ./configure; make ; \
     echo "/usr/local/lib/why3/isabelle" >> /usr/local/${ISAINSTDIR}/etc/components ; \
     make install \
  && mv /home/ubuntu/.isabelle/${ISAHEAPSDIR}/HOL-Word \
        /usr/local/${ISAHEAPSDIR}/ \
  && mv /home/ubuntu/.isabelle/${ISAHEAPSDIR}/Why3 \
        /usr/local/${ISAHEAPSDIR}/ \
  && mv /home/ubuntu/.isabelle/${ISAHEAPSDIR}/log/* \
        /usr/local/${ISAHEAPSDIR}/log/ \
  && why3 config --detect-provers && mv /home/ubuntu/.why3.conf /root/ ;\
  cd ..; rm -r why3-1.3.3
RUN echo 'cp /root/.why3.conf ${HOME}' >> /root/.novnc_setup

# Configuration of the file manager and the application launcher
COPY resources/dot_config/lxpanel/LXDE/panels/panel_isa2019 /root/.config/lxpanel/LXDE/panels/panel
