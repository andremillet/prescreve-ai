import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Comandos Simples',
    Svg: require('@site/static/img/undraw_typing.svg').default,
    description: (
      <>
        Use comandos intuitivos como <code>prescrever</code>, <code>solicitar</code> e <code>encaminhar</code> para criar documentos médicos rapidamente.
      </>
    ),
  },
  {
    title: 'Privacidade Garantida',
    Svg: require('@site/static/img/undraw_security.svg').default,
    description: (
      <>
        Todos os dados são processados localmente em seu dispositivo.
        Nenhuma informação de paciente é enviada para servidores externos.
      </>
    ),
  },
  {
    title: 'Adapta-se ao Seu Trabalho',
    Svg: require('@site/static/img/undraw_customize.svg').default,
    description: (
      <>
        Crie templates personalizados, adapte o modelo LLM para sua 
        especialidade e integre com sistemas existentes.
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
