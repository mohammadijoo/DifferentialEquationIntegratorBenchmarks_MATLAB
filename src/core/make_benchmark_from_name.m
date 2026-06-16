function b = make_benchmark_from_name(name)
%MAKE_BENCHMARK_FROM_NAME Create benchmark definition structs by name.
% This file intentionally provides runnable ODE/MOL/mechanical definitions for
% many new benchmark docs, and descriptor-only structs for planned DAE/SDE/DDE/BVP
% classes that need specialized solvers.

switch name
    case 'LinearTestEquation'
        lambda = -10; x0 = 1;
        b = first_order_benchmark(name, 'Linear Decay / Dahlquist Test Equation', [0 2], x0, @(t,y) lambda*y, true);
        b.exact = @(t) x0*exp(lambda*t);
        b.params.lambda = lambda;
    case 'HarmonicOscillator'
        omega = 1; q0 = 1; v0 = 0;
        b = mechanical_benchmark(name, 'Harmonic Oscillator', [0 40*pi], q0, v0, @(t,q) -omega^2*q);
        b.params.omega = omega;
        b.exact = @(t) [q0*cos(omega*t)+v0/omega*sin(omega*t); -q0*omega*sin(omega*t)+v0*cos(omega*t)];
        b.invariant = @(y) 0.5*y(2)^2 + 0.5*omega^2*y(1)^2;
    case 'VanDerPolOscillator'
        mu = 10;
        b = first_order_benchmark(name, 'Van der Pol Oscillator', [0 40], [2;0], @(t,y) [y(2); mu*(1-y(1)^2)*y(2)-y(1)], true);
        b.params.mu = mu;
    case 'LorenzSystem'
        sigma=10; rho=28; beta=8/3;
        b = first_order_benchmark(name, 'Lorenz System', [0 30], [1;1;1], @(t,y) [sigma*(y(2)-y(1)); y(1)*(rho-y(3))-y(2); y(1)*y(2)-beta*y(3)], false);
    case 'RobertsonKinetics'
        b = first_order_benchmark(name, 'Robertson Stiff Chemical Kinetics', [0 1e4], [1;0;0], @robertson_rhs, true);
        b.invariant = @(y) sum(y);
    case 'KeplerTwoBody'
        mu=1; q0=[1;0]; v0=[0;1];
        b = mechanical_benchmark(name, 'Kepler Two-Body Problem', [0 40*pi], q0, v0, @(t,q) -mu*q/(norm(q)^3));
        b.params.mu = mu;
        b.invariant = @(y) 0.5*(y(3)^2+y(4)^2)-mu/norm(y(1:2));

    case 'LogisticGrowth'
        r=2; K=1; b=first_order_benchmark(name,'Logistic Growth',[0 5],0.05,@(t,y) r*y.*(1-y/K),false);
        b.exact=@(t) K/(1+(K/0.05-1)*exp(-r*t));
    case 'LotkaVolterraPredatorPrey'
        a=1.5; bpar=1; c=3; d=1; b=first_order_benchmark(name,'Lotka Volterra Predator Prey',[0 20],[1;1],@(t,y)[a*y(1)-bpar*y(1)*y(2); d*y(1)*y(2)-c*y(2)],false);
    case 'SIR_EpidemicModel'
        beta=1.5; gamma=0.4; b=first_order_benchmark(name,'SIR Epidemic Model',[0 30],[0.99;0.01;0],@(t,y)[-beta*y(1)*y(2); beta*y(1)*y(2)-gamma*y(2); gamma*y(2)],false); b.invariant=@(y)sum(y);
    case 'BrusselatorODE'
        A=1; B=3; b=first_order_benchmark(name,'Brusselator ODE',[0 20],[1.2;3.1],@(t,y)[A+y(1)^2*y(2)-(B+1)*y(1); B*y(1)-y(1)^2*y(2)],false);
    case 'StiffBrusselatorRegime'
        A=1; B=3.5; eps=1e-2; b=first_order_benchmark(name,'Stiff Brusselator Regime',[0 20],[1.2;3.1],@(t,y)[A+y(1)^2*y(2)-(B+1)*y(1); (B*y(1)-y(1)^2*y(2))/eps],true);
    case 'DuffingOscillator'
        delta=0.2; alpha=-1; beta=1; gamma=0.3; omega=1.2;
        b=first_order_benchmark(name,'Duffing Oscillator',[0 100],[0;0],@(t,y)[y(2); -delta*y(2)-alpha*y(1)-beta*y(1)^3+gamma*cos(omega*t)],false);
    case 'ForcedDampedPendulum'
        q=0.5; A=1.2; w=2/3; b=first_order_benchmark(name,'Forced Damped Pendulum',[0 100],[0.2;0],@(t,y)[y(2); -q*y(2)-sin(y(1))+A*cos(w*t)],false);
    case 'RigidBodyEulerEquations'
        I1=2; I2=1; I3=2/3; b=first_order_benchmark(name,'Rigid Body Euler Equations',[0 50],[1;0.8;0.5],@(t,w)[((I2-I3)/I1)*w(2)*w(3); ((I3-I1)/I2)*w(3)*w(1); ((I1-I2)/I3)*w(1)*w(2)],false);
        b.invariant=@(w)0.5*(I1*w(1)^2+I2*w(2)^2+I3*w(3)^2);
    case 'ProtheroRobinsonProblem'
        lambda=-1000; phi=@(t) sin(t); phip=@(t) cos(t); b=first_order_benchmark(name,'Prothero Robinson Problem',[0 5],phi(0),@(t,y) lambda*(y-phi(t))+phip(t),true); b.exact=@(t)phi(t);
    case 'HIRESProblem'
        b=first_order_benchmark(name,'HIRES Problem',[0 321.8122],[1;0;0;0;0;0;0;0.0057],@hires_rhs,true);
    case 'OregonatorBelousovZhabotinsky'
        s=77.27; w=0.161; q=8.375e-6; b=first_order_benchmark(name,'Oregonator Belousov Zhabotinsky',[0 360],[1;2;3],@(t,y)[s*(y(2)+y(1)*(1-q*y(1)-y(2))); (y(3)-(1+y(1))*y(2))/s; w*(y(1)-y(3))],true);
    case 'PollutionModelODE'
        b=first_order_benchmark(name,'Pollution Model ODE',[0 60],linspace(0.1,1,20).',@(t,y) pollution_rhs(y),true);
    case 'AkzoNobelChemicalKinetics'
        b=first_order_benchmark(name,'Akzo Nobel Chemical Kinetics',[0 180],[0.437;0.00123;0;0.007;0;0],@akzo_rhs,true);
    case 'RingModulatorCircuitODE'
        b=first_order_benchmark(name,'Ring Modulator Circuit ODE',[0 1e-3],zeros(5,1),@(t,y) -1000*y + [sin(2*pi*1000*t);0;0;0;0],true);
    case 'AllenCahnMOL_StiffODE'
        b=mol_benchmark(name,'Allen Cahn MOL Stiff ODE',64,[0 1],@(x)0.1*sin(pi*x),@(t,u,L) 1e-3*L*u + u-u.^3,true);
    case 'HeatEquation1D'
        b=mol_benchmark(name,'Heat Equation 1D',64,[0 0.5],@(x)sin(pi*x),@(t,u,L) 0.01*L*u,true);
        b.exact=[];
    case 'AdvectionEquation1D'
        b=first_order_benchmark(name,'Advection Equation 1D MOL',[0 1],sin(2*pi*(0:63)'/64),@(t,u) advection_periodic_rhs(u,1,1/64),false);
    case 'WaveEquation1D'
        b=wave_mol_benchmark(name,'Wave Equation 1D');
    case 'ViscousBurgersEquation'
        b=first_order_benchmark(name,'Viscous Burgers Equation MOL',[0 1],sin(2*pi*(0:63)'/64),@(t,u) burgers_rhs(u,1/64,0.01),true);
    case 'InviscidBurgersEquation'
        b=first_order_benchmark(name,'Inviscid Burgers Equation MOL',[0 0.2],0.5+sin(2*pi*(0:63)'/64),@(t,u) burgers_rhs(u,1/64,0),false);
    case 'FisherKPPEquation'
        b=mol_benchmark(name,'Fisher KPP Equation',64,[0 5],@(x)exp(-100*(x-0.5).^2),@(t,u,L) 0.001*L*u + u.*(1-u),true);
    case 'GrayScottReactionDiffusion'
        b=gray_scott_benchmark(name);
    case 'KortewegDeVriesEquation'
        b=first_order_benchmark(name,'Korteweg de Vries Equation MOL',[0 1],sech_grid(64),@(t,u) kdv_rhs(u,1/64),false);
    case 'KuramotoSivashinskyEquation'
        b=first_order_benchmark(name,'Kuramoto Sivashinsky Equation MOL',[0 1],0.01*sin(2*pi*(0:63)'/64),@(t,u) ks_rhs(u,1/64),true);
    case 'CahnHilliardEquation'
        b=first_order_benchmark(name,'Cahn Hilliard Equation MOL',[0 0.1],0.1*cos(2*pi*(0:63)'/64),@(t,u) cahn_hilliard_rhs(u,1/64),true);
    case 'DoublePendulum'
        b=first_order_benchmark(name,'Double Pendulum',[0 30],[pi/2;pi/2;0;0],@double_pendulum_rhs,false);
    case 'HenonHeilesHamiltonian'
        b=first_order_benchmark(name,'Henon Heiles Hamiltonian',[0 200],[0;0.1;0.4;0],@henon_heiles_rhs,false);
        b.invariant=@(y)0.5*(y(3)^2+y(4)^2)+0.5*(y(1)^2+y(2)^2)+y(1)^2*y(2)-y(2)^3/3;
    case 'ChargedParticleInMagneticField'
        b=first_order_benchmark(name,'Charged Particle In Magnetic Field',[0 50],[1;0;0;0;1;0],@(t,y)[y(4:6); cross(y(4:6),[0;0;1])],false);
    case 'NBodyGravitationalProblem'
        b=first_order_benchmark(name,'N Body Gravitational Problem',[0 10],[-1;0;1;0;0;0;0;0.4;0;-0.4;0;0],@three_body_rhs,false);
    case 'PlanarRestrictedThreeBodyProblem'
        b=first_order_benchmark(name,'Planar Restricted Three Body Problem',[0 20],[0.5;0;0;1],@cr3bp_rhs,false);
    case 'FPUTLattice'
        b=first_order_benchmark(name,'FPUT Lattice',[0 100],fput_initial(8),@(t,y) fput_rhs(y,8),false);
    case 'TodaLattice'
        b=first_order_benchmark(name,'Toda Lattice',[0 50],fput_initial(8),@(t,y) toda_rhs(y,8),false);
    otherwise
        b = planned_descriptor(name);
end
end

function b = first_order_benchmark(name, displayName, tspan, y0, rhs, stiff)
b = struct(); b.name=name; b.displayName=displayName; b.equationClass='ode_first_order';
b.tspan=tspan; b.y0=y0(:); b.rhs=rhs; b.stiff=stiff; b.implemented=true; b.exact=[]; b.invariant=[];
end

function b = mechanical_benchmark(name, displayName, tspan, q0, v0, acceleration)
b = struct(); b.name=name; b.displayName=displayName; b.equationClass='mechanical_separable';
b.tspan=tspan; b.y0=[q0(:);v0(:)]; b.rhs=@(t,y)[y(numel(q0)+1:end); acceleration(t,y(1:numel(q0)))];
b.stiff=false; b.implemented=true; b.mechanical.q0=q0(:); b.mechanical.v0=v0(:); b.mechanical.acceleration=acceleration; b.exact=[]; b.invariant=[];
end

function b = mol_benchmark(name, displayName, N, tspan, initFun, rhsFun, stiff)
x=linspace(0,1,N+2).'; x=x(2:end-1); dx=x(2)-x(1); e=ones(N,1); L=spdiags([e -2*e e],[-1 0 1],N,N)/(dx*dx);
b=first_order_benchmark(name,displayName,tspan,initFun(x),@(t,u)rhsFun(t,u,L),stiff); b.grid.x=x; b.grid.dx=dx; b.equationClass='pde_mol';
end

function b = wave_mol_benchmark(name)
N=64; x=linspace(0,1,N+2).'; x=x(2:end-1); dx=x(2)-x(1); e=ones(N,1); L=spdiags([e -2*e e],[-1 0 1],N,N)/(dx*dx); c=1;
u0=sin(pi*x); v0=zeros(N,1); b=first_order_benchmark(name,'Wave Equation 1D',[0 2],[u0;v0],@(t,y)[y(N+1:end); c^2*L*y(1:N)],false); b.equationClass='pde_mol';
end

function b = gray_scott_benchmark(name)
N=32; x=linspace(0,1,N).'; u=ones(N,1); v=zeros(N,1); v(abs(x-0.5)<0.1)=0.25; y0=[u;v]; dx=1/N;
b=first_order_benchmark(name,'Gray Scott Reaction Diffusion',[0 10],y0,@(t,y) gray_scott_rhs(y,N,dx),true); b.equationClass='pde_mol';
end

function b = planned_descriptor(name)
b = struct(); b.name=name; b.displayName=name; b.equationClass='planned_non_ode_or_special'; b.tspan=[0 1]; b.y0=0; b.rhs=[]; b.stiff=false; b.implemented=false; b.exact=[]; b.invariant=[];
end

function dy = robertson_rhs(t,y)
dy=[-0.04*y(1)+1e4*y(2)*y(3); 0.04*y(1)-1e4*y(2)*y(3)-3e7*y(2)^2; 3e7*y(2)^2];
end
function dy = hires_rhs(t,y)
dy=zeros(8,1); dy(1)=-1.71*y(1)+0.43*y(2)+8.32*y(3)+0.0007; dy(2)=1.71*y(1)-8.75*y(2); dy(3)=-10.03*y(3)+0.43*y(4)+0.035*y(5); dy(4)=8.32*y(2)+1.71*y(3)-1.12*y(4); dy(5)=-1.745*y(5)+0.43*y(6)+0.43*y(7); dy(6)=-280*y(6)*y(8)+0.69*y(4)+1.71*y(5)-0.43*y(6)+0.69*y(7); dy(7)=280*y(6)*y(8)-1.81*y(7); dy(8)=-280*y(6)*y(8)+1.81*y(7);
end
function dy = pollution_rhs(y)
n=numel(y); A=gallery('tridiag',n,0.1,-1,0.05); dy=A*y + 0.01*sin(y);
end
function dy = akzo_rhs(t,y)
dy=zeros(6,1); k1=18.7; k2=0.58; k3=0.09; dy(1)=-k1*y(1)*sqrt(max(y(2),0)); dy(2)=-k1*y(1)*sqrt(max(y(2),0))-k2*y(2)*y(3); dy(3)=k1*y(1)*sqrt(max(y(2),0))-k2*y(2)*y(3)-k3*y(3); dy(4)=k2*y(2)*y(3); dy(5)=k3*y(3); dy(6)=0;
end
function du = advection_periodic_rhs(u,c,dx)
du = -c*(u-circshift(u,1))/dx;
end
function du = burgers_rhs(u,dx,nu)
du = -u.*(u-circshift(u,1))/dx + nu*(circshift(u,-1)-2*u+circshift(u,1))/(dx^2);
end
function y0 = sech_grid(N)
x=linspace(-1,1,N).'; y0=sech(10*x).^2;
end
function du = kdv_rhs(u,dx)
dux=(circshift(u,-1)-circshift(u,1))/(2*dx); duxxx=(circshift(u,-2)-2*circshift(u,-1)+2*circshift(u,1)-circshift(u,2))/(2*dx^3); du=-6*u.*dux-duxxx;
end
function du = ks_rhs(u,dx)
du2=(circshift(u,-1)-2*u+circshift(u,1))/(dx^2); du4=(circshift(u,-2)-4*circshift(u,-1)+6*u-4*circshift(u,1)+circshift(u,2))/(dx^4); du=-u.*(circshift(u,-1)-circshift(u,1))/(2*dx)-du2-du4;
end
function du = cahn_hilliard_rhs(u,dx)
lap=@(v)(circshift(v,-1)-2*v+circshift(v,1))/(dx^2); mu=u.^3-u-0.01*lap(u); du=lap(mu);
end
function dy = gray_scott_rhs(y,N,dx)
u=y(1:N); v=y(N+1:end); Du=2e-5; Dv=1e-5; F=0.04; K=0.06; lap=@(z)(circshift(z,-1)-2*z+circshift(z,1))/(dx^2); uvv=u.*v.^2; du=Du*lap(u)-uvv+F*(1-u); dv=Dv*lap(v)+uvv-(F+K)*v; dy=[du;dv];
end
function dy=double_pendulum_rhs(t,y)
th1=y(1); th2=y(2); w1=y(3); w2=y(4); g=9.81; m1=1; m2=1; L1=1; L2=1; d=th1-th2; den1=(m1+m2)*L1-m2*L1*cos(d)^2; den2=(L2/L1)*den1; a1=(m2*L1*w1^2*sin(d)*cos(d)+m2*g*sin(th2)*cos(d)+m2*L2*w2^2*sin(d)-(m1+m2)*g*sin(th1))/den1; a2=(-m2*L2*w2^2*sin(d)*cos(d)+(m1+m2)*(g*sin(th1)*cos(d)-L1*w1^2*sin(d)-g*sin(th2)))/den2; dy=[w1;w2;a1;a2];
end
function dy=henon_heiles_rhs(t,y)
q1=y(1); q2=y(2); p1=y(3); p2=y(4); dy=[p1;p2;-q1-2*q1*q2;-q2-q1^2+q2^2];
end
function dy=three_body_rhs(t,y)
q=reshape(y(1:6),2,3); v=reshape(y(7:12),2,3); a=zeros(2,3); for i=1:3, for j=1:3, if i~=j, r=q(:,j)-q(:,i); a(:,i)=a(:,i)+r/(norm(r)^3+eps); end, end, end; dy=[v(:);a(:)];
end
function dy=cr3bp_rhs(t,y)
mu=0.0121505856; x=y(1); yy=y(2); vx=y(3); vy=y(4); r1=sqrt((x+mu)^2+yy^2); r2=sqrt((x-1+mu)^2+yy^2); ax=2*vy+x-(1-mu)*(x+mu)/r1^3-mu*(x-1+mu)/r2^3; ay=-2*vx+yy-(1-mu)*yy/r1^3-mu*yy/r2^3; dy=[vx;vy;ax;ay];
end
function y0=fput_initial(N)
q=zeros(N,1); q(1)=0.1; p=zeros(N,1); y0=[q;p];
end
function dy=fput_rhs(y,N)
q=y(1:N); p=y(N+1:end); alpha=0.25; qext=[0;q;0]; force=zeros(N,1); for i=1:N, force(i)=(qext(i+2)-2*qext(i+1)+qext(i))+alpha*((qext(i+2)-qext(i+1))^2-(qext(i+1)-qext(i))^2); end; dy=[p;force];
end
function dy=toda_rhs(y,N)
q=y(1:N); p=y(N+1:end); qext=[0;q;0]; force=zeros(N,1); for i=1:N, force(i)=exp(qext(i)-qext(i+1))-exp(qext(i+1)-qext(i+2)); end; dy=[p;force];
end
