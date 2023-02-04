export default function Card({ name }) {
  return (
    <div className="min-w-[20%] card shadow-md bg-gray-50 border border-gray-300 text-gray-900">
      <div className="card-body">
        <h2 className="card-title text-gray-900">{name}</h2>
      </div>
    </div>
  );
}
